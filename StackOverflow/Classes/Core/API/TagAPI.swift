import Foundation
import Alamofire

class TagAPI {
    func consume(_ callback: @escaping (Result<[String:AnyObject]>) -> ()) {
        let link = "https://api.stackexchange.com/2.2/tags?order=desc&sort=popular&site=stackoverflow"

        let url = URL(string: link)!
        
        Alamofire.request(url, method: .get).validate(statusCode: 200..<500).responseJSON { (response) in
            switch response.result {
            case .success(let JSON):
                
                let statusCode = response.response!.statusCode
                
                guard statusCode == 200 else {
                    callback(.failure(.description(response.debugDescription)))
                    return
                }
                
                guard let json = JSON as? [String:AnyObject] else {
                    if response.result.isSuccess {
                        callback(.success(["":"" as AnyObject]))
                        return
                    }
                    
                    callback(.failure(.description("")))
                    return
                }
                
                callback(.success(json))
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
}
