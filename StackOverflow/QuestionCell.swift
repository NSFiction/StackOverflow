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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func viewModel(question object: NSDictionary) {

        title.text = object.valueForKey("title") as? String
        vote.text  = "\(object.valueForKey("score")!)"
        user.text  = object.valueForKey("display_name") as? String

        let profile = object.valueForKey("profile_image") as! String
        if profile.containsString("https") {
            photoUser.downloadedFrom(profile,
                                     destination: Constants.DESTINATION,
                                     path: Constants.FILEPATH)
        }
    }

}
