//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController() -> UIViewController? {
        weak var topVC = shared.keyWindow?.rootViewController
        while true {
            if let presented = topVC?.presentedViewController {
                topVC = presented
            } else if let nav = topVC as? UINavigationController {
                topVC = nav.visibleViewController
            } else if let tab = topVC as? UITabBarController {
                topVC = tab.selectedViewController
            } else {
                break
            }
        }
        return topVC
    }
    
    ///This method should be call before changing the root view controller if you have changed the color of status bar.
    func removeCustomStatusBar() {
        if #available(iOS 13.0, *) {
            let tag = 38482
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            
            if let statusBar = keyWindow?.viewWithTag(tag) {
                statusBar.removeFromSuperview()
            }
        }
    }
    
    private class func _share(_ data: [Any],
                               sender: UIViewController,
                               applicationActivities: [UIActivity]?,
                              setupViewControllerCompletion: ((UIActivityViewController) -> Void)?) {
        let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: applicationActivities)
        setupViewControllerCompletion?(activityViewController)
        DispatchQueue.main.async {
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                popoverController.sourceView = sender.view
                popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            }
            UIApplication.topViewController()?.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    class func share(_ data: Any...,
                     sender:UIViewController,
                     applicationActivities: [UIActivity]? = nil,
                     setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
        _share(data, sender: sender, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
    }
    class func share(_ data: [Any],
                     sender:UIViewController,
                     applicationActivities: [UIActivity]? = nil,
                     setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
        _share(data, sender: sender, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
    }
}

