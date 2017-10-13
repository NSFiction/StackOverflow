import UIKit

final class AnswerViewController: UIViewController {

    private let service: Service
    private let questionId: Int64

    init(service: Service, questionId: Int64) {
        self.service = service
        self.questionId = questionId

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Answer"
        self.view.backgroundColor = .white
    }

}
