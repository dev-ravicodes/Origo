//
//  UIFont+Extension.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import UIKit

extension UIFont{
    
    /// Font Work Poppins Light
    ///
    /// - Parameter size: Font size you need
    /// - Returns: your custom font for custom size
    class func urbanistLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Urbanist-Light", size: size)!
    }
    class func urbanistBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Urbanist-Bold", size: size)!
    }
    class func urbanistMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Urbanist-Medium", size: size)!
    }
    class func urbanistRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Urbanist-Regular", size: size)!
    }
    class func urbanistSemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Urbanist-SemiBold", size: size)!
    }
}
