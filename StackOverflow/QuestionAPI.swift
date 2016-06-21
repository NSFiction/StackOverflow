//
//  QuestionAPI.swift
//  StackOverflow
//
//  Created by Bruno Da luz on 6/18/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation
import Alamofire

class QuestionAPI {

    func consume(category category: String, completion: Result<NSMutableArray> -> Void) {

        let URL = "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=\(category)&site=stackoverflow&filter=!9YdnSIN18"


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
                let objects = self.validationJSON(enumerates)
                questions.addObject(objects)
            }

            completion(.Success(questions))
        }

    }

    func validationJSON(enumerates: NSDictionary) -> NSDictionary {
        let objects = NSMutableDictionary()

        for (key, value) in enumerates {

            if key as! String == "title" {
                objects.setValue(value, forKeyPath: "title")
            }

            if key as! String == "body" {
                objects.setValue(value, forKeyPath: "body")
            }

            if key as! String == "score" {
                objects.setValue(value as! Int, forKeyPath: "score")
            }

            if key as! String == "question_id" {
                objects.setValue(value as! Int, forKeyPath: "question_id")
            }

            if key as! String == "owner" {
                let display_name = self.validationDisplayName(value as! NSDictionary)
                objects.setValue(display_name, forKeyPath: "display_name")

                let profile_image = self.validationProfileName(value as! NSDictionary)
                objects.setValue(profile_image, forKeyPath: "profile_image")
            }
        }
        return objects
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
