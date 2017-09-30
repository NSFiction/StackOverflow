import UIKit
import RxSwift

class TagViewController: UIViewController {

    fileprivate var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let service: Service
    private var viewModel: TagViewModel?

    private(set) var tags: Variable<[TagViewModel]> = Variable([])

    struct Cell {
        static let reuseIdentifier = "cellIdentifier"
    }

    init(service: Service) {
        self.service = service

        super.init(nibName: nil, bundle: nil)

        let api = TagSyncApi(service: service)
        viewModel = TagViewModel(api: api)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "TAG"
        self.view.backgroundColor = .white

        createLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadContent()
    }

    private func loadContent() {

        guard let endPoint = StackOverflowAPI.tag() else {
            fatalError("[TAG] An error occurred while try get endPoint!!!")
        }

        viewModel?.find(through: endPoint)
        viewModel?.data.asObservable().bind(to: tableView.rx.items(cellIdentifier: Cell.reuseIdentifier,
                                                                   cellType: UITableViewCell.self)) { _ , tag, cell in
                                                                    cell.textLabel?.text = tag.name
        }.addDisposableTo(disposeBag)
    }
}

extension TagViewController {

    func createLayout() {
        tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
