//
//  ImageExtension.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request,
                                                    queue: NSOperationQueue.mainQueue(),
                                                    completionHandler: { (response, data, error) in
                self.image = UIImage(data: data!)
            })
        }
    }
}