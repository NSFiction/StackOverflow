import UIKit
import RxSwift
import RxCocoa

protocol TagDelegate: class {
    func show(question tag: String)
}

final class TagViewController: UIViewController {

    fileprivate var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let service: Service
    private var viewModel: TagViewModel?

    private weak var delegate: TagDelegate?

    struct Cell {
        static let reuseIdentifier = "cellIdentifier"
    }

    init(service: Service, delegate: TagDelegate) {
        self.service = service
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)

        let api = SyncApi(service: service)
        viewModel = TagViewModel(api: api)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Tags"
        self.view.backgroundColor = .white

        createLayout()
        loadContent()
        setupTableViewCellWhenTapped()
    }

    private func loadContent() {
        guard let endPoint = StackOverflowAPI.tag() else {
            fatalError("[TAG] An error occurred while try get endPoint!!!")
        }

        viewModel?.find(through: endPoint)

        let observable = viewModel?.data.asObservable()
        observable?.bind(to: tableView.rx.items(cellIdentifier: Cell.reuseIdentifier,
                                                cellType: UITableViewCell.self)) { row , tag, cell in
                                                    cell.textLabel?.text = tag.name
                                                    cell.accessoryType = .disclosureIndicator
                                                    if row % 2 == 0 {
                                                        cell.backgroundColor = .groupTableViewBackground
                                                    } else {
                                                        cell.backgroundColor = .white
                                                    }
            }.addDisposableTo(disposeBag)
    }

    private func setupTableViewCellWhenTapped() {
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            if let tag = self?.viewModel?.data.value[indexPath.item] {
                self?.delegate?.show(question: tag.name)
            }
        }).addDisposableTo(disposeBag)
    }
}

extension TagViewController {

    func createLayout() {
        tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none

        self.view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
