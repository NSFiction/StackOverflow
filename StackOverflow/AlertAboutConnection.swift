//
//  Network.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import Foundation
import UIKit

class AboutConnection {

    func alert(viewController viewController: UIViewController) {
        let alertController = UIAlertController(title: "Network Error",
                                                message: "Check your network connection",
                                                preferredStyle: UIAlertControllerStyle.Alert)

        let okAction = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.Default,
                                     handler: nil)
        alertController.addAction(okAction)

        viewController.presentViewController(alertController,
                                             animated: true,
                                             completion: nil)
    }

}