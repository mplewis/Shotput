import UIKit

class SendRequestViewController: UIViewController {

    @IBOutlet weak var requestInfo: UILabel!
    
    var request: Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let r = request else { return }
        requestInfo.text = "\(r)"
    }

}
