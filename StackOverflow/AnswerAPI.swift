//
//  AnswerAPI.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 01/04/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import Foundation
import Alamofire

class AnswerAPI {

    func consume(question_id: Int, completion: Result<NSMutableArray> -> Void) {

        let URL = "https://api.stackexchange.com/2.2/questions/\(question_id)/answers?order=desc&sort=activity&site=stackoverflow"

        Alamofire.request(.GET, URL).response { (request, response, data, error) in

            guard error == nil else {
                completion(.Failure(error))
                return
            }

            guard response?.statusCode == 200 else {
                completion(.Failure(error))
                return
            }

            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)

            let items = json.valueForKey("items") as! NSArray

            let questions = NSMutableArray()
            for item in items {
                let enumerates = item as! NSDictionary
                let objects = NSMutableDictionary()

                for (key, value) in enumerates {

                    if key as! String == "owner" {
                        if key as! String == "owner" {
                            let display_name = self.validationDisplayName(value as! NSDictionary)
                            objects.setValue(display_name, forKeyPath: "display_name")

                            let profile_image = self.validationProfileName(value as! NSDictionary)
                            objects.setValue(profile_image, forKeyPath: "profile_image")
                        }
                    }

                }
                questions.addObject(objects)
            }
            completion(.Success(questions))
        }
    }

    private func validationDisplayName(value: NSDictionary) -> String {
        let owner = value

        if (owner.valueForKeyPath("display_name")) != nil {
            if owner.valueForKey("display_name")?.length > 0 {
                return owner.valueForKey("display_name") as! String
            }
        }
        return ""
    }

    private func validationProfileName(value: NSDictionary) -> String {
        let owner = value

        if (owner.valueForKeyPath("profile_image")) != nil {
            if (owner.valueForKey("profile_image")?.length > 0) {
                return owner.valueForKey("profile_image") as! String
            }
        }
        return ""
    }

}
