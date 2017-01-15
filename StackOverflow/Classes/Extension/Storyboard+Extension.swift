import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case Main
        case Question
        case Answer
    }

    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
}
