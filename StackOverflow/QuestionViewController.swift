//
//  QuestionViewController.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let api = Api()
    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory,
                                                                     domain: .UserDomainMask)
    let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

    var tag: String = ""
    var arrQuestions = NSArray()

    @IBOutlet weak var tableViewQuestion: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        loadQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: String = "Cell"

        let questionCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! QuestionCell

//        let question = arrQuestions.objectAtIndex(indexPath.row) as! Question
//        questionCell.viewModel(question: question, destination: destination, filePath: filePath)

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
//        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let answerController = mainStoryboard.instantiateViewControllerWithIdentifier("answerController") as! AnswerController
//
//        let question = arrQuestions.objectAtIndex(indexPath.row) as! Question
//        answerController.question = question
//        self.navigationController?.pushViewController(answerController, animated: true)
    }

//    func loadQuestions() {
//
//        let api = Api()
//
//        if api.getConnection() {
//
//            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)
//
//            api.getTaggedWithClosure(tag, completion: { (result) in
//                if result.count > 0 {
//
//                    self.arrQuestions = self.allObjects(result)
//                    self.tableViewQuestion.reloadData()
//
//                }
//                HUD.hide(animated: true)
//            })
//
//        }
//    }

//    func allObjects(result: NSMutableArray) -> NSArray {
//        let coreDao = CoreDaoQuestion()
//        coreDao.validation(result)
//
//        return coreDao.fetch()
//    }

    func checkNetwork() -> Void {
        let connection = Network()
        connection.checkNetwork(self)
    }
}
