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
    
    let api = Api()
    
    var tag:String = ""
    var arrQuestions = NSMutableArray()
    
    @IBOutlet weak var tableViewQuestion: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:String = "Cell"
        
        let questionCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! QuestionCell
        
        let question = arrQuestions.objectAtIndex(indexPath.row) as! NSDictionary
        questionCell.viewModel(question)
        
        return questionCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if api.getConnection() {
            callAnswerController(indexPath)
        } else {
            checkNetwork()
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQuestions.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Infos().numberOfSections
    }
    
    func callAnswerController(indexPath: NSIndexPath) {
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let answerController = mainStoryboard.instantiateViewControllerWithIdentifier("answerController") as! AnswerController
        
        let question = arrQuestions.objectAtIndex(indexPath.row)
        answerController.titleAnswer = question.valueForKey("title") as! String
        answerController.question_id = question.valueForKey("question_id") as! Int
        self.navigationController?.pushViewController(answerController, animated: true)
    }
    
    func loadQuestions() {
        
        let api = Api()
        
        if api.getConnection() {

            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)
            
            api.getTaggedWithClosure(tag, completion: { (result) in
                if result.count > 0 {
                    self.arrQuestions = result
                    self.tableViewQuestion.reloadData()
                }
                HUD.hide(animated: true)
            })
            
        }
    }
    
    func checkNetwork() -> Void {
        let connection = Network()
        connection.checkNetwork(self)
    }
}
