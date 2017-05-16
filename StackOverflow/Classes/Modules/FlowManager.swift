import UIKit

final class FlowManager {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    func start() {
        showTag()
        window.makeKeyAndVisible()
    }
    
    private func showTag() {
        let tagController = TagViewController()
        let navigation = UINavigationController(rootViewController: tagController)
        window.rootViewController = navigation
    }
}
