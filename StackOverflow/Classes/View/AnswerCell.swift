import UIKit
import Alamofire

class AnswerCell: UITableViewCell {

    @IBOutlet weak var photoUser: UIImageView!
    @IBOutlet weak var user: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func viewModel(answer object: NSDictionary) {
        self.user.text = object.value(forKey: "display_name") as? String
        let profileImage = object.value(forKey: "profile_image") as! String

        if let url = URL(string: profileImage) {
            photoUser.downloadedFrom(url)
        }
    }

}
