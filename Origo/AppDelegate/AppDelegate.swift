//
//  AppDelegate.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 24/01/24.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0)
        initializeLibraries()
        disableDarkMode()
        setRootController()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }

}

