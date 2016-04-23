import UIKit
import XLForm
import Alamofire
import MapKit

class SingleRequestViewController: XLFormViewController {

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
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Basic Authentication"))
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Additional Headers"))
        form.addFormSection(section)

        section = XLFormSectionDescriptor.formSectionWithTitle("Basic Authentication")
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeAccount, title: "Username"))
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeAccount, title: "Password"))
        form.addFormSection(section)

        section = XLFormSectionDescriptor.formSectionWithTitle(
            "Additional Headers",
            sectionOptions: XLFormSectionOptions.CanInsert.union(.CanDelete).union(.CanReorder),
            sectionInsertMode: .Button
        )
        row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeSelectorPush, title: "Header")
        row.selectorOptions = ["Option 1", "Option 2", "Option 3"]
        section.multivaluedRowTemplate = row
        form.addFormSection(section)
        
        section = XLFormSectionDescriptor.formSection()
        section.addFormRow(XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Follow Redirects"))
        form.addFormSection(section)
        
        self.form = form
    }

}
