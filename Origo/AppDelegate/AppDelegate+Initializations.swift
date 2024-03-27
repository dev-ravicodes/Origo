//
//  AppDelegate+Initializations.swift
//  Whetness
//
//  Created by Kamaljeet Punia on 22/09/20.
//  Copyright © 2020 Kamaljeet Punia. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire

///Define any method here which we want to use in app delegate & call it from app delegate class.
extension AppDelegate {
    
    func initializeLibraries() {
        configIQKeyboard()
    }
    
    func configIQKeyboard(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarConfiguration.previousNextDisplayMode = .alwaysShow
    }
    
    func disableDarkMode(){
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
    }
    
    func setRootController() {
        var vc = ScreenManager.getRootViewController()
//#if targetEnvironment(simulator)
//        vc = ScreenManager.getController(storyboard: .authentication, controller: ShowCaseVC.self)
//#endif
        let navVC = UINavigationController(rootViewController: vc)
        navVC.navigationBar.isHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        UIView.performTransitionOnWindow()
    }
    
    func checkAppUpdate(){
        DispatchQueue.global().async {
            do {
                _ = try VersionCheck.shared.isUpdateAvailable(completion: { update, identifier, error in
                    if let error = error {
                        print(error)
                    } else if let update = update, let identifier = identifier, update{
                        DispatchQueue.main.async {
                            UIApplication.topViewController()?.showUpdateAlert(message: "App update available, please update for best experience!", okCallback: {
                                if let url = URL(string: "itms-apps://itunes.apple.com/app/\(identifier)") {
                                    UIApplication.shared.open(url)
                                }
                            })
                        }
                    }
                })
            } catch {
                print(error)
            }
        }
    }
    
}
