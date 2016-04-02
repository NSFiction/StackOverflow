//
//  QuestionController.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit
import PKHUD

class QuestionController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tag:String = ""
    var arrQuestions = NSMutableArray()
    
    @IBOutlet weak var tableViewQuestion: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = tag
        
        HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)
        
        loadQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:String = "Cell"
        
        let questionCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! QuestionCell
        
        let info = arrQuestions.objectAtIndex(indexPath.row)
        
        questionCell.title.text = info.valueForKey("title") as? String
        questionCell.vote.text  = info.valueForKey("score") as? String
        questionCell.user.text  = info.valueForKey("display_name") as? String
        questionCell.photoUser.imageFromUrl((info.valueForKey("profile_image") as? String)!)
        
        return questionCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQuestions.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Infos().numberOfSections
    }
    
    func loadQuestions() {
        
        let api = Api()
        
        if api.getConnection() {
            
            api.getTaggedWithClosure(tag, completion: { (result) in
                if result.count > 0 {
                    HUD.hide(animated: true)
                    self.arrQuestions = result
                    self.tableViewQuestion.reloadData()
                }
            })
            
        } else {
            
            let connection = Network()
            connection.checkNetwork(self)
            
        }
    }
    
}
