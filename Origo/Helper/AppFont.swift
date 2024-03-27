//
//  AppFont.swift
//  TimeApp
//
//  Created by Kamaljeet Punia on 09/04/20.
//  Copyright © 2020 Tina. All rights reserved.
//

import Foundation
import UIKit

//MARK: Enumeration
enum AppFont: String {

    case regular = "Roboto-Regular"
    case bold = "Roboto-Bold"
    case light = "Roboto-Light"
    case medium = "Roboto-Medium"

    func fontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

