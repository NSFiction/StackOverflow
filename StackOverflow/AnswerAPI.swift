//
//  AnswerAPI.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 01/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation
import Alamofire

class AnswerAPI: FetchAPI {
    func consume<T>(object object: T, callback: Result<NSArray> -> ()) {
        let URL = "https://api.stackexchange.com/2.2/questions/\(object)/answers?order=desc&sort=activity&site=stackoverflow"

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
                let jSON = jSONObject as? NSDictionary
                else {
                    callback(.Failure(error))
                    return
            }

            callback(.Success(jSON.valueForKey("items") as! NSArray))
        }
    }
}
