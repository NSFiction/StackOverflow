import Foundation

enum JSONError: Error {
    case description(String)
}

enum Result<T> {
    case success(T)
    case failure(JSONError)
}
