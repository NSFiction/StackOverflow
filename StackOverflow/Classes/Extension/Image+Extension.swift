import UIKit
import Alamofire

extension UIImageView {
    func downloadedFrom(_ link: URL) {
        self.af_setImage(withURL: link)
    }
}
