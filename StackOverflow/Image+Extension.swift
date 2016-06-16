//
//  Image+Extension.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 02/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    func downloadedFrom(link: String, destination: Request.DownloadFileDestination, path: String) {

        Alamofire.download(.GET, link, destination: destination)
            .response { _, response, data, _ in
                if let
                    data = data,
                    resumeDataString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    print("Resume Data: \(resumeDataString)")
                } else {

                    let pathComponent = response!.suggestedFilename
                    let filePath = "\(path)/\(pathComponent!)"

                    self.image = UIImage(contentsOfFile: filePath)

                }
        }
    }
}
