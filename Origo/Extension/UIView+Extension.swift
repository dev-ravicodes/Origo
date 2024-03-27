//
//  UIView+Extension.swift
//  TimeApp
//
//  Created by Kamaljeet Punia on 08/04/20.
//  Copyright © 2020 Tina. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func roundCornerWithWidth() {
        self.layer.cornerRadius = 2// self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    func roundCornerWithHeight() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func addSubviewWithAnimation(_ view: UIView) {
        UIView.transition(with: self, duration: 0.40, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            self.addSubview(view)
        }) { (finish) in
            //
        }
    }
    
    func removeFromSuperViewWithAnimation() {
        if let superView = self.superview {
            UIView.transition(with: superView, duration: 0.40, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                self.removeFromSuperview()
            }) { (finish) in
                //
            }
        }
    }
    
    func addShadowWithRoundCorner(radius: CGFloat = 10, color: UIColor = .black, opacity: Float = 0.4, offSet: CGSize = .zero, shadowRadius: CGFloat = 10) {
        for layer in layer.sublayers ?? [] {
            if layer.isKind(of: CAShapeLayer.self) {
                layer.removeFromSuperlayer()
            }
            
        }
        let shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        
        shadowLayer.borderWidth = 2.0
        shadowLayer.borderColor = UIColor.red.cgColor
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func dropShadow(color: UIColor = .black, opacity: Float = 0.05, offSet: CGSize = CGSize(width: 0, height: 15), shadowRadius: CGFloat = 15) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = shadowRadius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    func addBorderWithShadowAndCornerRadius(borderColor: UIColor) {
        layer.borderWidth = 1.5
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = 10.0
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.2
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func performLeftToRightTransition() {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.layer.add(transition, forKey: nil)
    }
    
    func performRightToLeftTransition() {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.layer.add(transition, forKey: nil)
    }
    
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]? = [2, 1], radius: CGFloat, color: UIColor, width: CGFloat) -> CALayer {
        let borderLayer = CAShapeLayer()
        
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineDashPattern = pattern
        borderLayer.lineWidth = width
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        
        layer.addSublayer(borderLayer)
        return borderLayer
    }
    
    // For insert layer in Foreground
    func addBlackGradientLayerInForeground(colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    
    // For insert layer in background
    func addBlackGradientLayerInBackground(colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    static func performTransitionOnWindow() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            //
        }, completion: nil)
    }
    
    func addBlurView(style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.9
        self.addSubview(blurEffectView)
    }
    
    func layerGradient(colors:[UIColor]) {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        //        layer.frame.origin = CGPointMake(0.0,0.0)
        //        layer.cornerRadius = CGFloat(frame.width / 2)
        //        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        //        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.locations = [0.0, 1.0]
        layer.colors = colors.map{$0.cgColor}
        self.layer.insertSublayer(layer, at: 0)
    }
        func addBottomShadow() {
            layer.masksToBounds = false
            layer.shadowRadius = 4
            layer.shadowOpacity = 1
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 0 , height: 2)
            layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                         y: bounds.maxY - layer.shadowRadius,
                                                         width: bounds.width,
                                                         height: layer.shadowRadius)).cgPath
        }
}

public extension UIView {
    
    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    /// SwifterSwift: Height of view.
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// SwifterSwift: Check if view is in RTL format.
    var isRightToLeft: Bool {
        if #available(tvOS 10.0, *) {
            return effectiveUserInterfaceLayoutDirection == .rightToLeft
        } else {
            return false
        }
    }
    
    
    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    /// SwifterSwift: Size of view.
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    /// SwifterSwift: Width of view.
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// SwifterSwift: x origin of view.
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// SwifterSwift: y origin of view.
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
}
