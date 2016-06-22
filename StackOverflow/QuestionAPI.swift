//
//  QuestionAPI.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 6/18/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation
import Alamofire

class QuestionAPI: FetchAPI {
    func consume<T>(object object: T, callback: Result<NSArray> -> ()) {
        let URL = "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=\(object)&site=stackoverflow&filter=!9YdnSIN18"


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

            callback(.Success(jSON.valueForKey("items") as! NSArray))
        }

    }

}
