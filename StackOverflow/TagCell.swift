//
//  TagCell.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 01/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit

class TagCell: UITableViewCell {

    @IBOutlet weak var category: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func viewModel(_ title: String) {
        category.text = title
    }

}
