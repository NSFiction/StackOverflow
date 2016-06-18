//
//  CheckNetwork.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 6/18/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import Foundation
import Alamofire

struct Network {
    static let hasConnection = (NetworkReachabilityManager()?.isReachable)!
}
