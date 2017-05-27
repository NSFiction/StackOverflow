import UIKit
import PKHUD

class TagViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    fileprivate var tableView: UITableView!
    private var categories = Array<String>()

    struct Cell {
        static let reuseIdentifier = "cellIdentifier"
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

        cell.textLabel?.text = categories[indexPath.item]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    private func loadCategories() {
        if Network.hasConnection {
            HUD.flash(.labeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)

            let consume = ConsumeTag()
            consume.fetch({ (result) in

                HUD.hide(animated: true)

                switch result {
                case .success(let value):
                    self.categories = value
                    self.tableView.reloadData()

                case .failure(let error):
                    print("An error occurred: \(error.localizedDescription)")
                }
            })
            
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
