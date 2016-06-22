//
//  ConsumeAnswer.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 6/21/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import Foundation

class ConsumeAnswer {

    func fetch(question_id: Int, callback: Result<NSMutableArray> -> ()) {

        let answerAPI = AnswerAPI()
        answerAPI.consume(object: question_id) { (result) in
            switch result {
            case .Success(let value):
                callback(.Success(self.validation(json: value)))
                break

            case .Failure(let error):
                callback(.Failure(error))
                break
            }
        }
    }

    private func validation(json json: NSArray) -> NSMutableArray {
        let questions = NSMutableArray()
        let profile = NSMutableDictionary()

        for (_, value) in json.enumerate() {
            let owner = value.valueForKey("owner") as! NSDictionary

            let display_name = self.getDisplayName(owner)
            let profile_image = self.getProfileName(owner)

            profile.setValue(display_name, forKeyPath: "display_name")
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
