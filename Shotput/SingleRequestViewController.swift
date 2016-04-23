import UIKit
import XLForm
import Alamofire
import MapKit

class Tags {
    static let enableBasicAuth = "enableBasicAuth"
    static let enableAddlHeaders = "enableAddlHeaders"
}

class SingleRequestViewController: XLFormViewController {
    
    var hiddenSections: [String: XLFormSectionDescriptor?] = [
        Tags.enableBasicAuth: nil,
        Tags.enableAddlHeaders: nil,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let form = XLFormDescriptor(title: "Add Event")
        var section: XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        section = XLFormSectionDescriptor.formSection()
        
        row = XLFormRowDescriptor(tag: nil, rowType:XLFormRowDescriptorTypeSelectorPush, title: "Method")
        var selectorOptions: [XLFormOptionsObject] = []
        let methods = ["GET", "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS"]
        for method in methods {
            selectorOptions.append(XLFormOptionsObject(value: method, displayText: method))
        }
        row.selectorOptions = selectorOptions
        row.value = XLFormOptionsObject(value: methods[0], displayText: methods[0])
        section.addFormRow(row)
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeURL, title: "URL"))
        form.addFormSection(section)
        
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

        section = XLFormSectionDescriptor.formSectionWithTitle("Basic Authentication")
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeAccount, title: "Username"))
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeAccount, title: "Password"))
        section.hidden = true
        hiddenSections[Tags.enableBasicAuth] = section;
        form.addFormSection(section)

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
        
        self.form = form
    }

    override func formRowDescriptorValueHasChanged(formRow: XLFormRowDescriptor!, oldValue: AnyObject!, newValue: AnyObject!) {
        if let tag = formRow.tag, section = hiddenSections[tag], s = section {
            s.hidden = !newValue.boolValue
        }
    }
    
}
