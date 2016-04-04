//
//  AnswerCell.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit

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
    
    func viewModel(info: NSDictionary) {
        user.text  = info.valueForKey("display_name") as? String
        photoUser.downloadedFrom(link: (info.valueForKey("profile_image") as? String)!,
                                 contentMode: UIViewContentMode.ScaleToFill)
    }

}
