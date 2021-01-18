//
//  AppDelegate.swift
//  MicrosoftTodo
//
//  Created by linzsc on 11/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstVC = WelcomeViewController()
        
        let nav = UINavigationController(rootViewController: firstVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        return true
    }


}

