import UIKit
import RxSwift

class TagViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    fileprivate var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let service: Service
    private var viewModel: TagViewModel?
    private var categories: [Tag] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

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

        loadCategories()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Cell.reuseIdentifier)

        cell.textLabel?.text = categories[indexPath.item].name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    private func loadCategories() {
        if Network.hasConnection {
            viewModel?.find(url: StackOverflowAPI.tag()!).subscribe { [weak self] event in
                switch event {
                case .next(let elements):
                    self?.categories = elements
                    break
                case .error(let error):
                    print(error)
                    break
                case .completed:
                    print("completed")
                    break
                }
            }.disposed(by: disposeBag)
        }
    }
}

extension TagViewController {

    func createLayout() {
        tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
