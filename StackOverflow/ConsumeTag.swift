//
//  ConsumeTag.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 7/6/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation

class ConsumeTag {

    func fetch(_ callback: (Result<NSArray>) -> ()) {

        let tagAPI = TagAPI()
        tagAPI.consume() { (result) in
            switch result {
            case .success(let value):

                let categories = value.object(forKey: "items")?.value(forKey: "name") as! NSArray
                callback(.success(categories))

                break

            case .failure(let error):
                callback(.failure(error))
                break
            }
        }
    }

}
