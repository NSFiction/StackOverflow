import XCGLogger

let logger = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var flowManager: FlowManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        flowManager = FlowManager()
        flowManager.start()
        
        logger.setup(level: .debug,
                     showLogIdentifier: false,
                     showFunctionName: false,
                     showThreadName: false,
                     showLevel: false,
                     showFileNames: false,
                     showLineNumbers: true,
                     showDate: false,
                     writeToFile: nil,
                     fileLevel: .debug)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        logger.debug("App will Resign Active")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        logger.debug("App did enter background")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        logger.debug("App will enter foreground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        logger.debug("App did become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        logger.debug("App will terminate")
    }

}
