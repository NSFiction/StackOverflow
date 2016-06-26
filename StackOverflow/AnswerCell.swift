//
//  AnswerCell.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 02/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import Alamofire

class AnswerCell: UITableViewCell {

    @IBOutlet weak var photoUser: UIImageView!
    @IBOutlet weak var user: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func viewModel(answer object: NSDictionary) {
        self.user.text = object.valueForKey("display_name") as? String
        let profileImage = object.valueForKey("profile_image") as! String

        photoUser.downloadedFrom(profileImage,
                                 destination: Constants.DESTINATION,
                                 path: Constants.FILEPATH)
    }

}
