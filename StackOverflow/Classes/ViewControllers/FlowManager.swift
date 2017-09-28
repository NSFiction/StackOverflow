import UIKit

final class FlowManager {
    
    private var window: UIWindow
    private lazy var service: Service = {
        return Service()
    }()
    
    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.makeKeyAndVisible()
    }

    func start() {
        let tagController = TagViewController(service: service)
        let navigationController = MainNavigationController(rootViewController: tagController)
        self.window.rootViewController = navigationController
    }

    func showTop() {
        
    }
}
