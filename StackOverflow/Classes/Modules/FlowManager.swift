import UIKit

final class FlowManager {
    
    private var window: UIWindow
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.makeKeyAndVisible()
    }

    func start() {
        let tagController = TagViewController()
        let navigationController = MainNavigationController(rootViewController: tagController)
        self.window.rootViewController = navigationController
    }
}
