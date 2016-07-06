//
//  ConsumeCategory.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 7/6/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation

class ConsumeCategory {

    func fetch(callback: Result<NSArray> -> ()) {

        let categoryAPI = CategoryAPI()
        categoryAPI.consume() { (result) in
            switch result {
            case .Success(let value):

                let categories = value.objectForKey("items")?.valueForKey("name") as! NSArray
                callback(.Success(categories))

                break

            case .Failure(let error):
                callback(.Failure(error))
                break
            }
        }
    }

}
