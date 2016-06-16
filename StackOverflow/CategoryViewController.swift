//
//  ViewController.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 3/31/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit

struct Infos {
    let numberOfSections:Int = 1
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let api = Api()
    
    var categoryDic = NSMutableDictionary()
    var categoryArr = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadCategory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:String = "Cell"
        
        let tagCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! TagCell
        
        let title = self.categoryArr.objectAtIndex(indexPath.row) as! String
        tagCell.viewModel(title)
        
        return tagCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if api.getConnection() {
            callQuestionController(indexPath)
        } else {
            checkNetwork()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryArr.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Infos().numberOfSections
    }
    
    func callQuestionController(indexPath: NSIndexPath) {
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let question = mainStoryboard.instantiateViewControllerWithIdentifier("questionController") as! QuestionController
        
        let category = categoryArr.objectAtIndex(indexPath.row) as? String
        
        question.title = category
        question.tag = categoryDic.valueForKey(category!) as! String
        
        self.navigationController?.pushViewController(question, animated: true)
    }
    
    func checkNetwork() -> Void {
        let connection = Network()
        connection.checkNetwork(self)
    }

    func loadCategory() {
        categoryDic = ["iPhone" : "iphone",
                       "Cocoa Touch" : "cocoa-touch",
                       "UiKit" : "uikit",
                       "Objective-C" : "objective-c",
                       "Swift" : "swift"];
        
        categoryArr = categoryDic.allKeys
    }
}


