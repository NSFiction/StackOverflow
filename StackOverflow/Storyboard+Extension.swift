//
//  Storyboard+Extension.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 6/20/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case Main
        case Question
        case Answer
    }

    class func storyboard(storyboard: Storyboard, bundle: NSBundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
}
