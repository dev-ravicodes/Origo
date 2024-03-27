//
//  UIColor+Extension.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import UIKit

extension UIColor{
    static let lightGreyBackground = UIColor(named: "LightGrayBackground")
    static let accountTypeColor = UIColor(named: "AccountTypeBgColor")
    static let buttonBGColor = UIColor(named: "ButtonBGColor")
    static let TabBarBGColor = UIColor(named: "TabBarBGColor")
    static let TextFeildBgColor = UIColor(named: "TextFeildBgColor")
    static let TabBarTintColor = UIColor(named: "TabBarTintColor")
    
    func inverse() -> UIColor {
        let ciColor = CIColor(color: self)
        
        // get the current values and make the difference from white:
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
    }

}
