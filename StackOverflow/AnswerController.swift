//
//  AnswerController.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit
import PKHUD

class AnswerController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var question_id = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var tableViewAnswer: UITableView!
    
    var arrAnswer = NSArray()
    var titleAnswer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleLabel.text = titleAnswer
        
        loadAnswers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:String = "Cell"
        
        let answerCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! AnswerCell
        
        let info = arrAnswer.objectAtIndex(indexPath.row) as! NSDictionary
        answerCell.viewModel(info)
        
        return answerCell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAnswer.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func loadAnswers() {
        
        let api = Api()
        
        if api.getConnection() {
            
            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)
            
            api.getAnswersWithClosure(question_id, completion: { (result) in
                if result.count > 0 {
                    self.arrAnswer = result
                    self.tableViewAnswer.reloadData()
                } else {
                    self.tableViewAnswer.hidden = true
                }
                HUD.hide(animated: true)
            })
            
        }
    }
}
