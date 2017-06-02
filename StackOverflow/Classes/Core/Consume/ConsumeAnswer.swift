import Foundation

class ConsumeAnswer {

    func fetch(_ question_id: Int, callback: @escaping (Result<NSMutableArray>) -> ()) {

        let answerAPI = AnswerAPI()
        answerAPI.consume(object: question_id) { (result) in
            switch result {
            case .success(let value):
                callback(.success(self.validation(json: value)))
                break

            case .failure(let error):
                callback(.failure(error))
                break
            }
        }
    }

    fileprivate func validation(json: NSArray) -> NSMutableArray {
        let questions = NSMutableArray()
        let profile = NSMutableDictionary()

        for (_, value) in json.enumerated() {
            let owner = (value as AnyObject).value(forKey: "owner") as! NSDictionary

            let display_name = self.getDisplayName(owner)
            let profile_image = self.getProfileName(owner)

            profile.setValue(display_name, forKeyPath: "display_name")
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
