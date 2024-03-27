//
//  Gradient Button.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import UIKit


enum LogType: String {
    case error
    case warning
    case success
}

class Logger {

 static func printLog(_ logType: LogType,_ message: String){
        switch logType {
        case LogType.error:
            debugPrint("\n🛑 Error: \(message)\n")
        case LogType.warning:
            debugPrint("\n⚠️ Warning: \(message)\n")
        case LogType.success:
            debugPrint("\n📗 Success: \(message)\n")
        }
    }

}
