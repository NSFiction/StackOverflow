//
//  ConsumeQuestion.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/21/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation

class ConsumeQuestion {

    func fetch(category: String, callback: Result<NSMutableArray> -> ()) {

        let questionAPI = QuestionAPI()
        questionAPI.consume(object: category) { (result) in
            switch result {
            case .Success(let value):
                callback(.Success(self.validationJSON(value)))
                break

            case .Failure(let error):
                callback(.Failure(error))
                break
            }
        }
    }

    private func validationJSON(objects: NSArray) -> NSMutableArray {

        let questions = NSMutableArray()

        for (_, value) in objects.enumerate() {

            let profile = NSMutableDictionary()

            let title = value.valueForKey("title")
            let body = value.valueForKey("body")
            let score = value.valueForKey("score")
            let question_id = value.valueForKey("question_id")
            
            profile.setValue(title, forKeyPath: "title")
            profile.setValue(body, forKeyPath: "body")
            profile.setValue(score as? Int, forKeyPath: "score")
            profile.setValue(question_id as? Int, forKeyPath: "question_id")

            let owner = value.valueForKey("owner") as! NSDictionary

            let display_name = self.getDisplayName(owner)
            profile.setValue(display_name, forKeyPath: "display_name")

            let profile_image = self.getProfileName(owner)
            profile.setValue(profile_image, forKeyPath: "profile_image")

            questions.addObject(profile)
        }
        return questions
    }

    private func getDisplayName(value: NSDictionary) -> String {
        let owner = value

        if (owner.valueForKeyPath("display_name")) != nil {
            if owner.valueForKey("display_name")?.length > 0 {
                return owner.valueForKey("display_name") as! String
            }
        }
        return ""
    }

    private func getProfileName(value: NSDictionary) -> String {
        let owner = value

        if (owner.valueForKeyPath("profile_image")) != nil {
            if (owner.valueForKey("profile_image")?.length > 0) {
                return owner.valueForKey("profile_image") as! String
            }
        }
        return ""
    }

}
