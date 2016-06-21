//
//  AnswerController.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire

class AnswerController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory,
                                                                     domain: .UserDomainMask)
    let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

    var arrAnswer = NSArray()

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var tableViewAnswer: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        titleLabel.text = question!.title
//        descriptionText.text = question!.body
//
//        loadAnswers(question!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell: String = "Cell"

        let answerCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! AnswerCell

//        let answer = arrAnswer.objectAtIndex(indexPath.row) as! Answer
//        answerCell.viewModel(answer: answer, destination: destination, filePath: filePath)

        return answerCell

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAnswer.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

//    func loadAnswers(question: Question) {
//
//        let api = Api()
//
//        if api.getConnection() {
//
//            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)
//
//            api.getAnswersWithClosure(question.question_id as! Int, completion: { (result) in
//                if result.count > 0 {
//
//                    self.countLabel.text = "\(result.count) Answer"
//                    self.tableViewAnswer.hidden = false
//
////                    self.arrAnswer = self.allObjects(result)
//                    self.tableViewAnswer.reloadData()
//
//                } else {
//                    self.hidden()
//                }
//                HUD.hide(animated: true)
//            })
//        }
//    }

    func hidden() {
        self.countLabel.hidden = true
        self.tableViewAnswer.hidden = true
    }
}
