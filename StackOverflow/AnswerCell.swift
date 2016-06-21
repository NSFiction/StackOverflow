//
//  AnswerCell.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
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
    
    func viewModel(answer object: String,
                          destination: Request.DownloadFileDestination,
                          filePath: String) {
        
        photoUser.downloadedFrom(object, destination: destination, path: filePath)
    }

}
