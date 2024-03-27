//

import Foundation
import UIKit

class ScreenManager {
    private init() {}
    
    enum Storyboard : String {
        case profile = "Profile"
        case home = "Home"
        case authentication = "Authentication"
        case onboarding = "OnBoarding"
        case addOutfit = "AddOutfit"
    }
    
    class func getRootViewController() -> UIViewController {
        if AppCache.shared.currentUser != nil {
            return getController(storyboard: .home, controller: RoundedTabbarController.self)
        }else{
                return getController(storyboard: .authentication, controller: LoginVC.self)
        }
    }
    
    class func getController<T: UIViewController>(storyboard:Storyboard,controller:T.Type) -> T {
        let storyBoard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        if let vc = storyBoard.instantiateViewController(withIdentifier: controller.className) as? T{
            return vc
        }
        fatalError(String(describing: controller.self))
    }
    
    class func gotoLogin() {
        UIApplication.shared.removeCustomStatusBar()
//        let vc = getController(storyboard: .main, controller: LoginVC.self)
//        let navVC = UINavigationController(rootViewController: vc)
//        navVC.isNavigationBarHidden = true
//        UIApplication.shared.delegate?.window??.rootViewController = navVC
        AppCache.shared.removeAllUserDefaults()
        UIView.performTransitionOnWindow()
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
