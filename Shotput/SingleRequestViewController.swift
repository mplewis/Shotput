import UIKit
import Eureka
import Alamofire
import MapKit

class SingleRequestViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.form
            +++= SegmentedRow<Alamofire.Method>("Method") {
                $0.title = "Method"
                $0.options = [.GET, .POST];
                $0.value = .GET
            }
            <<< LocationRow() {
                $0.title = "LocationRow"
                $0.value = CLLocation(latitude: -34.91, longitude: -56.1646)
            }
    }

}
