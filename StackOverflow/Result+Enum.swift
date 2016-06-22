//
//  ResultEnum.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/18/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(NSError?)

    init(value: T) {
        self = .Success(value)
    }

    init(error: NSError?) {
        self = .Failure(error)
    }
}
