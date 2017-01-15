//
//  AppDelegate.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 3/31/16.
//  Copyright © 2016 nFiction. All rights reserved.
//

import UIKit
import XCGLogger

let logger = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        logger.setup(.Debug, showLogIdentifier: false, showFunctionName: false, showThreadName: false, showLogLevel: false, showFileNames: false, showLineNumbers: true, showDate: false, writeToFile: nil, fileLogLevel: .Debug)

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
