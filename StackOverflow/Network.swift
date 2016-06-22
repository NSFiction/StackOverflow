//
//  CheckNetwork.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/18/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation
import Alamofire

struct Network {
    static let hasConnection = (NetworkReachabilityManager()?.isReachable)!
}
