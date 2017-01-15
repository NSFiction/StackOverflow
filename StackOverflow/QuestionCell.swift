//
//  QuestionCell.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 02/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import AlamofireImage
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func viewModel(question object: NSDictionary) {

        title.text = object.value(forKey: "title") as? String
        vote.text  = "\(object.value(forKey: "score")!)"
        user.text  = object.value(forKey: "display_name") as? String

        let profile = object.value(forKey: "profile_image") as! String
        
        let url = URL(string: profile)!
        photoUser.af_setImage(withURL: url)
    }

}
