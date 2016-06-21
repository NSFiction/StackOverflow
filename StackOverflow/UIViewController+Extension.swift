//
//  UIViewController+Extension.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 6/20/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
