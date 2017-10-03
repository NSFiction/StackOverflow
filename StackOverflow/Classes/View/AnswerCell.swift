import UIKit
import Alamofire

class AnswerCell: UITableViewCell {

    @IBOutlet weak var photoUser: UIImageView!
    @IBOutlet weak var user: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func viewModel(answer object: NSDictionary) {
        self.user.text = object.value(forKey: "display_name") as? String
        let profileImage = object.value(forKey: "profile_image") as! String
    }

}
