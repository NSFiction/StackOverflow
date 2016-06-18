//
//  AppDelegate.swift
//  StackOverflow
//
//  Created by Bruno da Luz on 3/31/16.
//  Copyright © 2016 Bruno da Luz. All rights reserved.
//

import UIKit
import XCGLogger

let logger = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        logger.setup(.Debug, showLogIdentifier: false, showFunctionName: false, showThreadName: false, showLogLevel: false, showFileNames: false, showLineNumbers: true, showDate: false, writeToFile: nil, fileLogLevel: .Debug)

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        logger.debug("App will Resign Active")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        logger.debug("App did enter background")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        logger.debug("App will enter foreground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        logger.debug("App did become active")
    }

    func applicationWillTerminate(application: UIApplication) {
        logger.debug("App will terminate")
    }

}
