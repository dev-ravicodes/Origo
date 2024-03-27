//
//  Bundle+Extension.swift
//  Hammer Parking
//
//  Created by yapapp on 10/27/22.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var bundleName:String?{
        return infoDictionary?["CFBundleName"] as? String
    }
    
    static func loadView<T>(withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(String(describing: type.self), owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
