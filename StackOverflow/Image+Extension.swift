//
//  Image+Extension.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 02/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    func downloadedFrom(_ link: URL) {
        self.af_setImage(withURL: link)
    }
}
