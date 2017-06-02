import UIKit

protocol FetchAPI {
    func consume<T>(object: T, callback: @escaping (Result<NSArray>) -> ())
}
