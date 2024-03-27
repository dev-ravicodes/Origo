//
//  RoundedTabbarController.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/02/24.
//

import UIKit

class RoundedTabbarController: UITabBarController {
    
    //MARK: Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for vc in self.viewControllers! {
            vc.tabBarItem.title = nil
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -32, right: 0)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if selectedIndex != 0 {
            removeGradient()
            addGraiednt()
            tabBar.borderColor = .blue
            tabBar.tintColor = .TabBarTintColor
            tabBar.unselectedItemTintColor = .white
            tabBar.items?[1].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            tabBar.items?[1].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
            tabBar.items?[1].badgeColor = .blue
        } else {
            removeGradient()
            tabBar.items?[1].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
            tabBar.items?[1].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            tabBar.items?[1].badgeColor = .red
            tabBar.unselectedItemTintColor = .black
            tabBar.tintColor = .accountTypeBg
        }

    }
    
    func addGraiednt() {
        let gradient = CAGradientLayer()
        if UIDevice.hasNotch {
            gradient.frame = CGRect(x: 0, y: self.tabBar.bounds.minY + 0, width: self.tabBar.bounds.width , height: 100)
        }
        else {
            gradient.frame = CGRect(x: 10, y: self.tabBar.bounds.minY + 4, width: self.tabBar.bounds.width - 20, height: 50)
        }
        gradient.colors = [UIColor.TabBarBGColor?.cgColor ?? UIColor.black.cgColor, UIColor.TabBarBGColor?.cgColor ?? UIColor.black.cgColor]
        gradient.cornerRadius = 26
        gradient.masksToBounds = true
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.4, y: 0.0)
        self.tabBar.layer.insertSublayer(gradient, at: 1)
    }
        
    func removeGradient() {
        if let sublayers = tabBar.layer.sublayers {
            for layer in sublayers {
                if let gradientLayer = layer as? CAGradientLayer {
                    gradientLayer.removeFromSuperlayer()
                }
            }
        }
    }
}
///**Custom Tabbar to increase height**
class CustomTabBar : UITabBar {
    
    @IBInspectable var tabHeight: CGFloat = 60
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if tabHeight > 0.0 {
            
            if #available(iOS 11.0, *) {
                sizeThatFits.height = tabHeight + window.safeAreaInsets.bottom
            } else {
                sizeThatFits.height = tabHeight
            }
        }
        return sizeThatFits
    }
}

