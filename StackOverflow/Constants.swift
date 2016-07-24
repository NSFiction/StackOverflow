//
//  Constants.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/17/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation
import Alamofire

class Constants {
    static let DESTINATION = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory,
                                                                               domain: .UserDomainMask)
    static let FILEPATH = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
}
