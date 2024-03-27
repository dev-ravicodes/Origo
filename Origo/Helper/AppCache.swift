//
//  Gradient Button.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import UIKit

class AppCache: NSObject {
    
    static let shared = AppCache()
    
    // MARK: - CLASS LIFE CYCLE
    private override init() {
        super.init()
    }
    
    var fcmToken: String? = nil
    
    // MARK: - VARIABLES
    var currentUser: UserData? {
        set{
            if let data = JSONEncoder().convertToData(newValue) {
                UserDefaults.standard.setValue(data, forKey: AppConstants.UserDefault.currentUser)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            if let data = UserDefaults.standard.data(forKey: AppConstants.UserDefault.currentUser) {
                return JSONDecoder().convertDataToModel(data)
            }
            return nil
        }
    }
        
    var token: String {
        return self.currentUser?.token ?? ""
    }
    
    var savedLoginDetails: LoginRequestModel? {
        set {
            if let value = newValue, let data = JSONEncoder().convertToData(value) {
                UserDefaults.standard.setValue(data, forKey: AppConstants.UserDefault.loginDetail)
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.setValue(nil, forKey: AppConstants.UserDefault.loginDetail)
                UserDefaults.standard.synchronize()
            }
        }
        get {
            if let data = UserDefaults.standard.data(forKey: AppConstants.UserDefault.loginDetail) {
                return JSONDecoder().convertDataToModel(data)
            }
            return nil
        }
    }
    
    var rememberMe: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppConstants.UserDefault.rememberMe)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: AppConstants.UserDefault.rememberMe)
        }
    }
    
    var showGuidelines: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppConstants.UserDefault.showGuidelines)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: AppConstants.UserDefault.showGuidelines)
        }
    }
    
    var newUser: Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppConstants.UserDefault.newUser)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: AppConstants.UserDefault.newUser)
        }
    }
        
    func removeAllUserDefaults() {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
        }
    }
    
}
