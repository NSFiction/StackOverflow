//
//  CategoryAPI.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 7/4/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation
import Alamofire

class TagAPI {
    func consume(_ callback: @escaping (Result<NSDictionary>) -> ()) {
        let URL = "https://api.stackexchange.com/2.2/tags?order=desc&sort=popular&site=stackoverflow"

        Alamofire.request(.GET, URL).response { (request, response, data, error) in

            guard error == nil else {
                callback(.Failure(error))
                return
            }

            guard response?.statusCode == 200 else {
                callback(.Failure(error))
                return
            }

            guard let jSONData = data,
                let jSONObject = try? NSJSONSerialization.JSONObjectWithData(jSONData, options: []),
                let jSON = jSONObject as? NSDictionary else {
                    callback(.Failure(error))
                    return
            }

            callback(.Success(jSON))
        }
    }
}
