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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: String = "Cell"

        let tagCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! TagCell

        var title = ""
        if searchActive {
            title = self.filtered[indexPath.row]
        } else {
            title = self.categories[indexPath.row] as! String
        }

        tagCell.viewModel(title)

        return tagCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if Network.hasConnection {
            callQuestionController(indexPath)
        } else {
            AboutConnection().alert(viewController: self)
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        }
        return self.categories.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func callQuestionController(indexPath: NSIndexPath) {
        let storyboard = UIStoryboard.storyboard(.Question)
        let identifier = QuestionViewController.storyboardIdentifier
        let question = storyboard.instantiateViewControllerWithIdentifier(identifier) as! QuestionViewController

        let category = categories[indexPath.row] as! String
        question.title = category
        question.category = category

        self.navigationController?.pushViewController(question, animated: true)
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.resignFirstResponder()
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let category = self.categories.filter({ (text) -> Bool in
            let tmp: NSString = text as! NSString
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
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
            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)

            let consume = ConsumeTag()
            consume.fetch({ (result) in

                HUD.hide(animated: true)

                switch result {
                case .Success(let value):
                    self.categories = value
                    self.tableView.reloadData()
                    break

                case .Failure(_):
                    // test
                    break
                }
            })

        }
    }

}
