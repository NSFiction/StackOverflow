//
//  Storyboard+Extension.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/20/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case Main
        case Question
        case Answer
    }

    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
}
