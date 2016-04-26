import UIKit
import XLForm

class RequestViewController: XLFormViewController {

    private var _request: NSURLRequest?
    var request: NSURLRequest? {
        didSet {
            guard let r = request else { return }
            print(r)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let form = XLFormDescriptor()
        let section = XLFormSectionDescriptor.formSection()
        let row = XLFormRowDescriptor(tag: nil, rowType: XLFormRowDescriptorTypeInfo, title: "Request in progress...")
        section.addFormRow(row)
        form.addFormSection(section)
        self.form = form
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset.top = topLayoutGuide.length
    }

}
