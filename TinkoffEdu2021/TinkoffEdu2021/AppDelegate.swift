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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //check is theme setted
        if (UserDefaults.standard.object(forKey: "Theme") == nil) {
            UserDefaults.standard.setValue("Classic", forKey: "Theme")
        }
       
        return true
    }
}
