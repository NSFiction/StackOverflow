//
//  FetchAPI.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/21/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit

protocol FetchAPI {
    func consume<T>(object object: T, callback: Result<NSArray> -> ())
}
