import Foundation
import UIKit

class AboutConnection {

    func alert(viewController: UIViewController) {
        let alertController = UIAlertController(title: "Network Error",
                                                message: "Check your network connection",
                                                preferredStyle: UIAlertControllerStyle.alert)

        let okAction = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default,
                                     handler: nil)
        alertController.addAction(okAction)

        viewController.present(alertController,
                                             animated: true,
                                             completion: nil)
    }

}
