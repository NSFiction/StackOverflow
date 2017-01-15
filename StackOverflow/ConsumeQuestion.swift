//
//  ConsumeQuestion.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/21/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation

class ConsumeQuestion {

    func fetch(_ category: String, callback: @escaping (Result<NSMutableArray>) -> ()) {

        let questionAPI = QuestionAPI()
        questionAPI.consume(object: category) { (result) in
            switch result {
            case .success(let value):
                callback(.success(self.validationJSON(value)))
                break

            case .failure(let error):
                callback(.failure(error))
                break
            }
        }
    }

    fileprivate func validationJSON(_ objects: NSArray) -> NSMutableArray {

        let questions = NSMutableArray()

        for (_, value) in objects.enumerated() {

            let profile = NSMutableDictionary()

            let title = (value as AnyObject).value(forKey: "title")
            let body = (value as AnyObject).value(forKey: "body")
            let score = (value as AnyObject).value(forKey: "score")
            let question_id = (value as AnyObject).value(forKey: "question_id")

            profile.setValue(title, forKeyPath: "title")
            profile.setValue(body, forKeyPath: "body")
            profile.setValue(score as? Int, forKeyPath: "score")
            profile.setValue(question_id as? Int, forKeyPath: "question_id")

            let owner = (value as AnyObject).value(forKey: "owner") as! NSDictionary

            let display_name = self.getDisplayName(owner)
            profile.setValue(display_name, forKeyPath: "display_name")

            let profile_image = self.getProfileName(owner)
            profile.setValue(profile_image, forKeyPath: "profile_image")

            questions.add(profile)
        }
        return questions
    }

    fileprivate func getDisplayName(_ value: NSDictionary) -> String {
        let owner = value

        if (owner.value(forKeyPath: "display_name")) != nil {
            if (owner.value(forKey: "display_name") as AnyObject).length > 0 {
                return owner.value(forKey: "display_name") as! String
            }
        }
        return ""
    }

    fileprivate func getProfileName(_ value: NSDictionary) -> String {
        let owner = value

        if (owner.value(forKeyPath: "profile_image")) != nil {
            if ((owner.value(forKey: "profile_image") as AnyObject).length > 0) {
                return owner.value(forKey: "profile_image") as! String
            }
        }
        return ""
    }

}
