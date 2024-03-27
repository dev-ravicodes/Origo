//
//  Environment.swift


import UIKit

struct Environment {
    
    private static let production: Bool = {
        #if DEBUG
        return false
        #else
        return true
        #endif
    }()
    
    static var isProduction: Bool {
        return self.production
    }
    
    static var isDebug: Bool {
        return !self.production
    }
    
    static var isApiLog: Bool = true
    static var isAGObjectLog: Bool = false
    
    static var isDeveloping: Bool = {
        if Environment.production {
            return false
        }
        return true
    }()
    
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}

struct AGApiLog {
    static func debug(_ message: Any..., filename: NSString = #file, function: String = #function, line: Int = #line) {
//        if Environment.isApiLog, Environment.isDebug {
            message.forEach {
                print($0)
            }
//        }
    }
}
