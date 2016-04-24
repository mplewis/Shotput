import UIKit
import XLForm
import Alamofire
import MapKit

class Tags {
    static let enableBasicAuth = "enableBasicAuth"
    static let enableAddlHeaders = "enableAddlHeaders"
}

enum SegueIdentifier: String {
    case SendRequestSegue = "SendRequestSegue"
}

class SingleRequestViewController: XLFormViewController {
    
    var hiddenSections: [String: XLFormSectionDescriptor?] = [
        Tags.enableBasicAuth: nil,
        Tags.enableAddlHeaders: nil,
    ]
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.form = buildForm()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let raw = segue.identifier, identifier = SegueIdentifier.init(rawValue: raw) else { return }
        switch identifier {
        case .SendRequestSegue:
            guard let dest = segue.destinationViewController as? SendRequestViewController else { return }
        }
    }
    
    // MARK: - XLForm

    override func formRowDescriptorValueHasChanged(formRow: XLFormRowDescriptor!, oldValue: AnyObject!, newValue: AnyObject!) {
        if let tag = formRow.tag, section = hiddenSections[tag], s = section {
            s.hidden = !newValue.boolValue
        }
    }
    
    // MARK: - Form builder
    
    func buildForm() -> XLFormDescriptor {
        let form = XLFormDescriptor(title: "Add Event")
        var section: XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        // MARK: Method and URL
        
        section = XLFormSectionDescriptor.formSection()
        row = XLFormRowDescriptor(tag: nil, rowType:XLFormRowDescriptorTypeSelectorPush, title: "Method")
        var selectorOptions: [XLFormOptionsObject] = []
        let methods = Method.allValues
        for method in methods {
            selectorOptions.append(XLFormOptionsObject(value: method.rawValue, displayText: "\(method)"))
        }
        row.selectorOptions = selectorOptions
        row.value = XLFormOptionsObject(value: methods[0].rawValue, displayText: "\(methods[0])")
        section.addFormRow(row)
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeURL, title: "URL"))
        form.addFormSection(section)
        
        // MARK: Options toggles
        
        section = XLFormSectionDescriptor.formSection()
        section.addFormRow(XLFormRowDescriptor(
            tag: Tags.enableBasicAuth,
            rowType: XLFormRowDescriptorTypeBooleanSwitch,
            title: "Basic Authentication"))
        section.addFormRow(XLFormRowDescriptor(
            tag: Tags.enableAddlHeaders,
            rowType: XLFormRowDescriptorTypeBooleanSwitch,
            title: "Additional Headers"))
        section.addFormRow(XLFormRowDescriptor(
            tag: nil,
            rowType: XLFormRowDescriptorTypeBooleanSwitch,
            title: "Follow Redirects"))
        form.addFormSection(section)
        
        // MARK: Basic auth
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Basic Authentication")
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeAccount, title: "Username"))
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeAccount, title: "Password"))
        section.hidden = true
        hiddenSections[Tags.enableBasicAuth] = section;
        form.addFormSection(section)
        
        // MARK: Additional headers
        
        section = XLFormSectionDescriptor.formSectionWithTitle(
            "Additional Headers",
            sectionOptions: XLFormSectionOptions.CanInsert.union(.CanDelete).union(.CanReorder),
            sectionInsertMode: .Button
        )
        row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeSelectorPush, title: "Header")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3"]
        section.multivaluedRowTemplate = row
        section.hidden = true
        hiddenSections[Tags.enableAddlHeaders] = section;
        form.addFormSection(section)
        
        // MARK: Send Request
        
        section = XLFormSectionDescriptor.formSection()
        row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeButton, title: "Send Request")
        row.action.formSegueIdenfifier = SegueIdentifier.SendRequestSegue.rawValue
        section.addFormRow(row)
        form.addFormSection(section)
        
        return form
    }
    
}
