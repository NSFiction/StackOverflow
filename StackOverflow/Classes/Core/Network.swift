import Foundation
import Alamofire

struct Network {
    static let hasConnection = (NetworkReachabilityManager()?.isReachable)!
}
