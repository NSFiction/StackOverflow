import Foundation

class ConsumeTag {

    func fetch(_ callback: @escaping (Result<Array<String>>) -> ()) {

        let tagAPI = TagAPI()
        tagAPI.consume() { (result) in
            switch result {
            case .success(let value):

                let categories = (value["items"] as AnyObject).value(forKey: "name") as! Array<String>
                callback(.success(categories))

                break

            case .failure(let error):
                callback(.failure(error))
                break
            }
        }
    }

}
