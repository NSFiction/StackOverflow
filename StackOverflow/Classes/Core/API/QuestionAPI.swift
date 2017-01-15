import Foundation
import Alamofire

class QuestionAPI: FetchAPI {
    func consume<T>(object: T, callback: @escaping (Result<NSArray>) -> ()) {
        let link = "https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=\(object)&site=stackoverflow&filter=!9YdnSIN18"

        let url = URL(string: link)

        Alamofire.request(url!, method: .get)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
                switch response.result {
                case .success(let JSON):
                    
                    let statusCode = response.response!.statusCode
                    
                    guard statusCode == 200 else {
                        callback(.failure(.description(response.debugDescription)))
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
