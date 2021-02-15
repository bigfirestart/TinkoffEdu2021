//
//  AppDelegate.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 13.02.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var logger = Logger()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    

    func applicationDidBecomeActive(_ application: UIApplication) {
        logger.stateChangeLog(fromState: "Inactive", toState: "Active", methodName: "applicationDidBecomeActive")
    }
    
    func applicationWillResignActive(_ application: UIApplication){
        logger.stateChangeLog(fromState: "Active", toState: "Inactive", methodName: "applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        logger.stateChangeLog(fromState: "Inactive", toState: "Background", methodName: "applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        logger.stateChangeLog(fromState: "Background", toState: "Inactive", methodName: "applicationWillEnterForeground")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        logger.stateChangeLog(fromState: "Background", toState: "Not Running", methodName: "applicationWillTerminate")
    }
}
