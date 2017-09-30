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
        let tagController = TagViewController(service: service, delegate: self)
        let navigationController = MainNavigationController(rootViewController: tagController)
        self.window.rootViewController = navigationController
    }

    func showQuestionView(element: String) {
        guard let navigationController = self.window.rootViewController as? MainNavigationController else {
            fatalError("ManNavigationController contain some error!!!")
        }

        let storyboard = UIStoryboard.storyboard(.Question)
        let identifier = QuestionViewController.storyboardIdentifier

        if let storyboard = storyboard.instantiateViewController(withIdentifier: identifier) as? QuestionViewController {
            navigationController.pushViewController(storyboard, animated: true)
        }
    }
}

extension FlowManager: TagDelegate {

    func show(question tag: String) {
        self.showQuestionView(element: tag)
    }

}
