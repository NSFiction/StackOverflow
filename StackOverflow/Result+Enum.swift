//
//  ResultEnum.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/18/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case description(String)
}

enum Result<T> {
    case success(T)
    case failure(JSONError)
}
