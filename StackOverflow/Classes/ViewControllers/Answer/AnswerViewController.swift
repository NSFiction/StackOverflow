import UIKit
import Alamofire

class AnswerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrAnswer = NSArray()
    var dicInfo = NSDictionary()

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var tableViewAnswer: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = dicInfo.value(forKey: "title") as? String
        descriptionText.text = dicInfo.value(forKey: "body") as? String

        let question_id = dicInfo.value(forKey: "question_id") as? Int
        loadAnswers(question_id!)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: String = "Cell"

        let answerCell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! AnswerCell

        let answer = arrAnswer.object(at: indexPath.row) as! NSDictionary
        answerCell.viewModel(answer: answer)

        return answerCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAnswer.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func loadAnswers(_ question_id: Int) {
        if Network.hasConnection {

            let consume = ConsumeAnswer()
            consume.fetch(question_id, callback: { (result) in

                switch result {
                case .success(let value):
                    self.arrAnswer = value
                    self.countLabel.text = "\(value.count) Answer"
                    self.tableViewAnswer.isHidden = false
                    self.tableViewAnswer.reloadData()
                    break

                case .failure(_):
                    self.hidden()
                    break
                }
            })

        } else {
            // alert about check network
        }
    }

    func hidden() {
        self.countLabel.isHidden = true
        self.tableViewAnswer.isHidden = true
    }
}
