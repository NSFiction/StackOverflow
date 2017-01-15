//
//  QuestionViewController.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 02/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import PKHUD

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var category: String = ""
    var arrQuestions = NSArray()

    @IBOutlet weak var tableViewQuestion: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: String = "Cell"

        let questionCell = tableView.dequeueReusableCell(withIdentifier: cell, for: indexPath) as! QuestionCell

        let question = arrQuestions.object(at: indexPath.row) as! NSDictionary
        questionCell.viewModel(question: question)

        return questionCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        if Network.hasConnection {
            callAnswerViewController(indexPath)
        } else {
            AboutConnection().alert(viewController: self)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQuestions.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func callAnswerViewController(_ indexPath: IndexPath) {
        let storyboard = UIStoryboard.storyboard(.Answer)
        let identifier = AnswerViewController.storyboardIdentifier
        let answerController = storyboard.instantiateViewController(withIdentifier: identifier) as! AnswerViewController
        let question = arrQuestions.object(at: indexPath.row) as! NSDictionary
        answerController.dicInfo = question
        self.navigationController?.pushViewController(answerController, animated: true)
    }

    func loadQuestions() {
        if Network.hasConnection {
            HUD.flash(.LabeledProgress(title: nil, subtitle: "Please wait..."), delay: 60.0)

            let consume = ConsumeQuestion()
            consume.fetch(category, callback: { (result) in

                HUD.hide(animated: true)

                switch result {
                case .success(let value):
                    self.arrQuestions = value
                    self.tableViewQuestion.reloadData()
                    break

                case .failure(_):
                    // test
                    break
                }
            })

        }
    }
}
