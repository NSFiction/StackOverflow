import Foundation

class ConsumeTag {

    func fetch(_ callback: @escaping (Result<NSArray>) -> ()) {

        let tagAPI = TagAPI()
        tagAPI.consume() { (result) in
            switch result {
            case .success(let value):

                let categories = (value["items"] as AnyObject).value(forKey: "name") as! NSArray
                callback(.success(categories))

                break

            case .failure(let error):
                callback(.failure(error))
                break
            }
        }
    }

}