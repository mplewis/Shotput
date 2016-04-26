import UIKit
import XLForm

class ResponseViewController: XLFormViewController {
    
    var response: NSHTTPURLResponse?
    var responseString: String?
    var responseJSON: AnyObject?
    var responseData: NSData?
    var error: NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
