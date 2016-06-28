//
//  CategoryViewController.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 3/31/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {

    let categoryArr: NSArray = Constants.CATEGORIES.allKeys
    let categoryDic: NSDictionary = Constants.CATEGORIES

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: String = "Cell"

        let tagCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! TagCell

        let title = self.categoryArr.objectAtIndex(indexPath.row) as! String
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
        return self.categoryArr.count
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func callQuestionController(indexPath: NSIndexPath) {

        let storyboard = UIStoryboard.storyboard(.Question)
        let identifier = QuestionViewController.storyboardIdentifier
        let question = storyboard.instantiateViewControllerWithIdentifier(identifier) as! QuestionViewController

        let category = categoryArr.objectAtIndex(indexPath.row) as? String

        question.title = category
        question.category = categoryDic.valueForKey(category!) as! String

        self.navigationController?.pushViewController(question, animated: true)
    }

}
