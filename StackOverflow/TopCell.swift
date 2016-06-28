//
//  TopCell.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/26/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit

class TopCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var answers: UILabel!
    @IBOutlet weak var view: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
