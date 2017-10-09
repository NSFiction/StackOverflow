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

        let questionController = QuestionViewController(service: service, tagSelected: element, delegate: self)
        navigationController.pushViewController(questionController, animated: true)
    }

    func showAnswerView(element: Int64) {
        guard let navigationController = self.window.rootViewController as? MainNavigationController else {
            fatalError("MainNavigationController contain some error!!!")
        }

        let answerController = AnswerViewController(service: service, questionId: element)
        navigationController.pushViewController(answerController, animated: true)
    }
}

extension FlowManager: TagDelegate {

    func show(question tag: String) {
        self.showQuestionView(element: tag)
    }

}

extension FlowManager: QuestionDelegate {

    func show(answer question: Int64) {
        self.showAnswerView(element: question)
    }

}
