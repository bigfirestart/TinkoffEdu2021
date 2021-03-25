//
//  AppDelegate.swift
//  TinkoffEdu2021
//
//  Created by Кирилл Лукьянов on 13.02.2021.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        //check is theme setted
        if (UserDefaults.standard.object(forKey: "Theme") == nil) {
            UserDefaults.standard.setValue("Classic", forKey: "Theme")
        }
        
        if (UserDefaults.standard.object(forKey: "UserApiId") == nil) {
            UserDefaults.standard.setValue(UUID().uuidString, forKey: "UserApiId")
        }
       
        return true
    }
}
