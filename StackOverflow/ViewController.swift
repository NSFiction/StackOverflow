//
//  ViewController.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 3/31/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit
import PKHUD

struct Infos {
    let numberOfSections:Int = 1
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewSO: UITableView!
    
    var category = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)
        
        loadCategory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:String = "Cell"
        
        let tagCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! TagCell
        
        tagCell.category.text = self.category.objectAtIndex(indexPath.row) as? String
        
        return tagCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let category = self.category.objectAtIndex(indexPath.row)
        print("category: \(category)")
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let question = mainStoryboard.instantiateViewControllerWithIdentifier("questionController") as! QuestionController
        question.tag = category as! String
        tableViewSO.deselectRowAtIndexPath(indexPath, animated: true)
        
        self.navigationController?.pushViewController(question, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Infos().numberOfSections
    }
    
    func loadCategory() -> Void {
        let api = Api()
        
        if api.getConnection() {
            
            api.getCategoryWithClosure { (category) in
                if category?.count > 0 {
                    HUD.hide(animated: true)
                    self.category = category!
                    self.tableViewSO.reloadData()
                }
            }
            
        } else {
            
            let connection = Network()
            connection.checkNetwork(self)
            
        }
    }
    
}


