//
//  UINavigationControllerExtension.swift
//  MyEarthLink
//
//  Created by IOS on 12/01/22.
//  Copyright © 2022 Kamal. All rights reserved.
//

import UIKit

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
