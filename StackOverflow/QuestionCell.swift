//
//  QuestionCell.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit
import Alamofire

class QuestionCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var photoUser: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func viewModel(question object: String,
                            destination: Request.DownloadFileDestination,
                            filePath: String) {

//        let titleAux = object.title
//        let voteAux = "\(object.vote as Int)"
//        let userAux = object.user
//        let profileAux = object.photoUser

//        title.text = titleAux
//        vote.text  = voteAux
//        user.text  = userAux

        if object.containsString("https") {
            photoUser.downloadedFrom(object, destination: destination, path: filePath)
        }
    }

}
