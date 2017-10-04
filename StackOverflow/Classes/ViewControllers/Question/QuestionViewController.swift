import UIKit
import RxSwift
import RxCocoa

final class QuestionViewController: UIViewController {

    fileprivate var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private var service: Service
    private let tagSelected: String
    private var viewModel: QuestionViewModel?

    struct Cell {
        static let reuseIdentifier = "cellIdentifier"
    }

    init(service: Service, tagSelected: String) {
        self.service = service
        self.tagSelected = tagSelected

        super.init(nibName: nil, bundle: nil)

        let api = SyncApi(service: service)
        viewModel = QuestionViewModel(api: api)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Questions"
        self.view.backgroundColor = .white

        createLayout()
        loadQuestions()
    }

    func loadQuestions() {
        guard let endPoint = StackOverflowAPI.question(through: tagSelected) else {
            fatalError("[TAG] An error occurred while try get endPoint!!!")
        }

        viewModel?.find(through: endPoint)

        let observable = viewModel?.data.asObservable()
        observable?.bind(to: tableView.rx.items(cellIdentifier: Cell.reuseIdentifier,
                                                cellType: QuestionCell.self)) { row , question, cell in
                                                    cell.titleLabel.text = question.title
                                                    if row % 2 == 0 {
                                                        cell.backgroundColor = .groupTableViewBackground
                                                    } else {
                                                        cell.backgroundColor = .white
                                                    }
        }.addDisposableTo(disposeBag)
    }
}

extension QuestionViewController {

    func createLayout() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(QuestionCell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.tableView = tableView

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

