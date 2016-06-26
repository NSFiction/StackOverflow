//
//  AnswerViewController.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 02/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire

class AnswerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory,
                                                                             domain: .UserDomainMask)
    private let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                                                               .UserDomainMask,
                                                               true)[0]

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
        let question_id = 37956419
        loadAnswers(question_id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell: String = "Cell"

        let answerCell = tableView.dequeueReusableCellWithIdentifier(cell, forIndexPath: indexPath) as! AnswerCell

        let answer = arrAnswer.objectAtIndex(indexPath.row) as! NSDictionary
        answerCell.viewModel(answer: answer)

        return answerCell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAnswer.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func loadAnswers(question_id: Int) {
        if Network.hasConnection {
            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 999.0)

            let consume = ConsumeAnswer()
            consume.fetch(question_id, callback: { (result) in

                HUD.hide(animated: true)

                switch result {
                case .Success(let value):
                    self.arrAnswer = value
                    self.countLabel.text = "\(value.count) Answer"
                    self.tableViewAnswer.hidden = false
                    self.tableViewAnswer.reloadData()
                    break

                case .Failure(_):
                    self.hidden()
                    break
                }
            })

        } else {
            // alert about check network
        }
    }

    func hidden() {
        self.countLabel.hidden = true
        self.tableViewAnswer.hidden = true
    }
}
