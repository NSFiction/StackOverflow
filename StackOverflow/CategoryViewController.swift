//
//  CategoryViewController.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 3/31/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import PKHUD

class CategoryViewController: UITableViewController {

    var categories = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: String = "Cell"

        let tagCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! TagCell

        let title = self.categories[indexPath.row] as! String
        tagCell.viewModel(title)

        return tagCell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if Network.hasConnection {
            callQuestionController(indexPath)
        } else {
            AboutConnection().alert(viewController: self)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
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

    func loadCategories() {
        if Network.hasConnection {
            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)

            let consume = ConsumeCategory()
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
