//
//  AnswerController.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire

class AnswerController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory,
                                                                     domain: .UserDomainMask)
    let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    
    var arrAnswer = NSArray()
    var dicAnswer = NSDictionary()
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var tableViewAnswer: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleLabel.text = dicAnswer.valueForKey("title") as? String
        descriptionText.text = dicAnswer.valueForKey("body") as? String
        
        loadAnswers(dicAnswer.valueForKey("question_id") as! Int)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:String = "Cell"
        
        let answerCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! AnswerCell
        
        let answer = arrAnswer.objectAtIndex(indexPath.row) as! NSDictionary
        answerCell.viewModel(answer: answer, destination: destination, filePath: filePath)
        
        return answerCell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAnswer.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func loadAnswers(question_id: Int) {
        
        let api = Api()
        
        if api.getConnection() {
            
            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)
            
            api.getAnswersWithClosure(question_id, completion: { (result) in
                if result.count > 0 {
                    self.arrAnswer = result
                    self.countLabel.text = "\(result.count) Answer"
                    self.tableViewAnswer.hidden = false
                    self.tableViewAnswer.reloadData()
                } else {
                    self.countLabel.hidden = true
                    self.tableViewAnswer.hidden = true
                }
                HUD.hide(animated: true)
            })
            
        }
    }
}
