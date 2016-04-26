import UIKit
import Alamofire

class ResultsTabBarController: UITabBarController {
    
    var request: Request?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let
            request = self.request,
            reqVC = viewControllers?[0] as? RequestViewController,
            resVC = viewControllers?[1] as? ResponseViewController
            else { return }
        sendRequest(request, reqVC: reqVC, resVC: resVC)
    }
    
    func sendRequest(request: Request, reqVC: RequestViewController, resVC: ResponseViewController) {
        guard let method = request.method.toAlamofire() else { return }
        Alamofire.request(method, request.url)
            .response { (request, response, data, error) in
                reqVC.request = request
                resVC.response = response
                resVC.responseData = data
                resVC.error = error
            }
            .responseString { response in
                resVC.responseString = response.result.value
            }
            .responseJSON { response in
                resVC.responseJSON = response.result.value
            }
    }

}
