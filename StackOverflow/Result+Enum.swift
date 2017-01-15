//
//  ResultEnum.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/18/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(NSError?)

    init(value: T) {
        self = .success(value)
    }

    init(error: NSError?) {
        self = .failure(error)
    }
}
