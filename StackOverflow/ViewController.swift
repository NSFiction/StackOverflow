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
    
    @IBOutlet weak var tableViewSO: UITableView!
    
    var tags = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadTags()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:String = "Cell"
        
        let tagCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! TagCell
        
        tagCell.category.text = self.tags.objectAtIndex(indexPath.row) as? String
        
        return tagCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let category = self.tags.objectAtIndex(indexPath.row)
        print(category)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Infos().numberOfSections
    }
    
    func loadTags() -> Void {
        let api = Api()
        
        if api.getConnection() {
            
            api.getCategoryWithClosure { (tags) in
                if tags?.count > 0 {
                    self.tags = tags!
                    self.tableViewSO.reloadData()
                }
            }
            
        } else {
            
            let alertController = UIAlertController(title: "Network Error",
                                                    message: "Check your network connection",
                                                    preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "OK",
                                         style: UIAlertActionStyle.Default,
                                         handler: nil)
            alertController.addAction(okAction)
            
            self.presentViewController(alertController,
                                       animated: true,
                                       completion: nil)
            
        }
    }

}


