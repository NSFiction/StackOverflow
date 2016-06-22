//
//  QuestionCell.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 02/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import Alamofire

class QuestionCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var photoUser: UIImageView!

    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory,
                                                                     domain: .UserDomainMask)
    let filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func viewModel(question object: NSDictionary) {

        let titleAux = object.valueForKey("title") as! String
        let voteAux = "\(object.valueForKey("score")!)"
        let userAux = object.valueForKey("display_name") as! String
        let profileAux = object.valueForKey("profile_image") as! String

        title.text = titleAux
        vote.text  = voteAux
        user.text  = userAux

        if profileAux.containsString("https") {
            photoUser.downloadedFrom(profileAux, destination: destination, path: filePath)
        }
    }

}
