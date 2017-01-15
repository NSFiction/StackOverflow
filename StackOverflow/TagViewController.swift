//
//  TagViewController.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 3/31/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import PKHUD

class TagViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var categories = NSArray()
    var searchActive: Bool = false
    var filtered: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: String = "Cell"

        let tagCell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! TagCell

        var title = ""
        if searchActive {
            title = self.filtered[indexPath.row]
        } else {
            title = self.categories[indexPath.row] as! String
        }

        tagCell.viewModel(title)

        return tagCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if Network.hasConnection {
            callQuestionController(indexPath)
        } else {
            AboutConnection().alert(viewController: self)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        }
        return self.categories.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func callQuestionController(_ indexPath: IndexPath) {
        let storyboard = UIStoryboard.storyboard(.Question)
        let identifier = QuestionViewController.storyboardIdentifier
        let question = storyboard.instantiateViewController(withIdentifier: identifier) as! QuestionViewController

        let category = categories[indexPath.row] as! String
        question.title = category
        question.category = category

        self.navigationController?.pushViewController(question, animated: true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let category = self.categories.filter({ (text) -> Bool in
            let tmp: NSString = text as! NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        filtered = category as! [String]
        if (filtered.count == 0) {
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
    }

    func loadCategories() {
        if Network.hasConnection {
            HUD.flash(.labeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)

            let consume = ConsumeTag()
            consume.fetch({ (result) in

                HUD.hide(animated: true)

                switch result {
                case .success(let value):
                    self.categories = value
                    self.tableView.reloadData()
                    break

                case .failure(_):
                    // test
                    break
                }
            })

        }
    }

}
