import UIKit
import XLForm
import Alamofire
import MapKit

class SingleRequestViewController: XLFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form = XLFormDescriptor(title: "Add Event")
        var section: XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        section = XLFormSectionDescriptor.formSection()
        
        row = XLFormRowDescriptor(tag: "title", rowType: XLFormRowDescriptorTypeText)
        row.cellConfigAtConfigure["textField.placeholder"] = "Title"
        section.addFormRow(row)
        
        self.form.addFormSection(section)

        /*
        
        XLFormDescriptor * form;
        XLFormSectionDescriptor * section;
        XLFormRowDescriptor * row;
        
        form = [XLFormDescriptor formDescriptorWithTitle:@"Add Event"];
        
        // First section
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        
        // Title
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title" rowType:XLFormRowDescriptorTypeText];
        [row.cellConfigAtConfigure setObject:@"Title" forKey:@"textField.placeholder"];
        [section addFormRow:row];
        
        // Location
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"location" rowType:XLFormRowDescriptorTypeText];
        [row.cellConfigAtConfigure setObject:@"Location" forKey:@"textField.placeholder"];
        [section addFormRow:row];
        
        // Second Section
        section = [XLFormSectionDescriptor formSection];
        [form addFormSection:section];
        
        // All-day
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"all-day" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"All-day"];
        [section addFormRow:row];
        
        // Starts
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"starts" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"Starts"];
        row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
        [section addFormRow:row];

         */
    }

}
