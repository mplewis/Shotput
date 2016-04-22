import UIKit
import Eureka

class SingleRequestViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.form
            +++= DateRow("Date") {
                $0.value = NSDate()
                $0.title = "The clock says:"
            }
            <<< CheckRow("Check") {
                $0.title = "Check"
                $0.value = true
            }
            <<< PhoneRow("Phone") {
                $0.placeholder = "Phone"
            }
    }

}
