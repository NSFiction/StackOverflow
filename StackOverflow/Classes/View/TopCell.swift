import UIKit

class TopCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var answers: UILabel!
    @IBOutlet weak var view: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
