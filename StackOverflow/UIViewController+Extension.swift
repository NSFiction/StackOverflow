//
//  UIViewController+Extension.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/20/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
