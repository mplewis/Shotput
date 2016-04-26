import UIKit
import XLForm
import Alamofire
import MapKit

enum Tag: String { case
    Method = "Method",
    URL = "URL",
    EnableBasicAuth = "EnableBasicAuth",
    EnableAddlHeaders = "EnableAddlHeaders",
    FollowRedirects = "FollowRedirects"
}

enum SegueIdentifier: String {
    case SendRequestSegue = "SendRequestSegue"
}

class SingleRequestViewController: XLFormViewController {
    
    var basicAuthSection: XLFormSectionDescriptor?
    var addlHeadersSection: XLFormSectionDescriptor?
    
    var method = Method.allValues[0]
    var url: NSURL?
    var followRedirects = false
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.form = buildForm()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let raw = segue.identifier, identifier = SegueIdentifier.init(rawValue: raw) else { return }
        switch identifier {
        case .SendRequestSegue:
            guard let dest = segue.destinationViewController as? ResultsTabBarController else { return }
            guard let u = url else { return }
            let request = Request(method: method, headers: nil, url: u, followRedirects: followRedirects)
            dest.request = request
        }
    }
    
    // MARK: - Form builder
    
    func buildForm() -> XLFormDescriptor {
        basicAuthSection = buildBasicAuthSection()
        addlHeadersSection = buildAddlHeadersSection()

        let form = XLFormDescriptor(title: "Add Event")
        form.addFormSection(buildMethodAndURLSection())
        form.addFormSection(buildOptionsTogglesSection())
        form.addFormSection(basicAuthSection!)
        form.addFormSection(addlHeadersSection!)
        form.addFormSection(buildSendRequestSection())
        return form
    }
    
    func buildMethodAndURLSection() -> XLFormSectionDescriptor {
        let section = XLFormSectionDescriptor.formSection()

        var row = XLFormRowDescriptor(tag: Tag.Method.rawValue, rowType:XLFormRowDescriptorTypeSelectorPush, title: "Method")
        var selectorOptions: [XLFormOptionsObject] = []
        for oneMethod in Method.allValues {
            selectorOptions.append(XLFormOptionsObject(value: oneMethod.rawValue, displayText: "\(oneMethod)"))
        }
        row.selectorOptions = selectorOptions
        row.value = XLFormOptionsObject(value: method.rawValue, displayText: "\(method)")
        row.onChangeBlock = { [weak self] _, newValue, _ in
            guard let
                opt = newValue as? XLFormOptionsObject,
                raw = opt.valueData() as? Int,
                method = Method.fromRaw(raw)
                else { return }
            self?.method = method
        }
        section.addFormRow(row)

        row = XLFormRowDescriptor(tag: Tag.URL.rawValue, rowType: XLFormRowDescriptorTypeURL, title: "URL")
        row.onChangeBlock = { [weak self] _, newValue, _ in
            guard let raw = newValue as? String else { return }
            self?.url = NSURL(string: raw)  // could be nil
        }
        section.addFormRow(row)

        return section
    }
    
    func buildOptionsTogglesSection() -> XLFormSectionDescriptor {
        let section = XLFormSectionDescriptor.formSection()
        
        var row = XLFormRowDescriptor(
            tag: Tag.EnableBasicAuth.rawValue,
            rowType: XLFormRowDescriptorTypeBooleanSwitch,
            title: "Basic Authentication")
        row.onChangeBlock = { [weak self] _, newValue, _ in
            guard let show = newValue as? Bool else { return }
            self?.basicAuthSection?.hidden = !show
        }
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(
            tag: Tag.EnableAddlHeaders.rawValue,
            rowType: XLFormRowDescriptorTypeBooleanSwitch,
            title: "Additional Headers")
        row.onChangeBlock = { [weak self] _, newValue, _ in
            guard let show = newValue as? Bool else { return }
            self?.addlHeadersSection?.hidden = !show
        }
        section.addFormRow(row)
        
        row = XLFormRowDescriptor(
            tag: Tag.FollowRedirects.rawValue,
            rowType: XLFormRowDescriptorTypeBooleanSwitch,
            title: "Follow Redirects")
        row.value = false
        row.onChangeBlock = { [weak self] _, newValue, _ in
            guard let followRedirects = newValue as? Bool else { return }
            self?.followRedirects = followRedirects
        }
        section.addFormRow(row)
        
        return section
    }
    
    func buildBasicAuthSection() -> XLFormSectionDescriptor {
        let section = XLFormSectionDescriptor.formSectionWithTitle("Basic Authentication")
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeAccount, title: "Username"))
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeAccount, title: "Password"))
        section.hidden = true
        return section
    }
    
    func buildAddlHeadersSection() -> XLFormSectionDescriptor {
        let section = XLFormSectionDescriptor.formSectionWithTitle(
            "Additional Headers",
            sectionOptions: XLFormSectionOptions.CanInsert.union(.CanDelete).union(.CanReorder),
            sectionInsertMode: .Button
        )
        let row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeSelectorPush, title: "Header")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3"]
        section.multivaluedRowTemplate = row
        section.hidden = true
        addlHeadersSection = section
        return section
    }
    
    func buildSendRequestSection() -> XLFormSectionDescriptor {
        let section = XLFormSectionDescriptor.formSection()
        let row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeButton, title: "Send Request")
        row.action.formBlock = { [weak self] (sender: XLFormRowDescriptor!) in
            if self?.url == nil {
                let alert = UIAlertController(
                    title: "Invalid URL",
                    message: "Please enter a valid URL for this request.",
                    preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self?.presentViewController(alert, animated: true, completion: nil)
                return
            }
            self?.performSegueWithIdentifier(SegueIdentifier.SendRequestSegue.rawValue, sender: self)
        }
        section.addFormRow(row)
        return section
    }
    
}
