//
//  AnswerAPI.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 01/04/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation
import Alamofire

class AnswerAPI: FetchAPI {
    func consume<T>(object: T, callback: @escaping (Result<NSArray>) -> ()) {
        let link = "https://api.stackexchange.com/2.2/questions/\(object)/answers?order=desc&sort=activity&site=stackoverflow"

        let url = URL(string: link)
        
        Alamofire.request(url!, method: .get)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
                switch response.result {
                case .success(let JSON):
                    
                    guard response.response?.statusCode == 200 else {
                        return
                    }
                    
                    guard let json = JSON as? [String:AnyObject] else {
                        if response.result.isSuccess {
                            callback(.success([]))
                            return
                        }
                        
                        callback(.failure(.description("")))
                        return
                    }
                    
                    callback(.success(json["items"] as! NSArray))
                    break
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
        }
    }
}
