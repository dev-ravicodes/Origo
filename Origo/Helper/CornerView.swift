//
//  CornerView.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import UIKit
import IQKeyboardManagerSwift

class TopCornerView: IQPreviousNextView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = UIScreen.main.bounds.size.width / 12
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
}

class TextfieldView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    
}

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.autocapitalizationType = .sentences // Set the default autocapitalization type you want.
        self.font = UIFont.urbanistRegular(ofSize: 16)
    }
}

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

class QuoteGradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        gradientLayer.frame.size = frame.size
        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame.size = frame.size
        l.startPoint = CGPoint(x: 0.0, y: 0.5)
        l.endPoint = CGPoint(x: 2.5, y: 0.5)
        layer.insertSublayer(l, at: 0)
        return l
    }()
}

class ContractGradientView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        gradientLayer.frame.size = frame.size
        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame.size = frame.size
        l.startPoint = CGPoint(x: 0.0, y: 0.5)
        l.endPoint = CGPoint(x: 2.5, y: 0.5)
        l.colors = [UIColor.orange.cgColor, UIColor.white.cgColor]
        layer.insertSublayer(l, at: 0)
        return l
    }()
}

class TemplateCornerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
    }
    
}

class ShadowCornerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -5, height: 5) // Adjust the values for the desired shadow direction
        layer.shadowRadius = 5
        layer.masksToBounds = false
        
    }
}

class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.masksToBounds = false
        layer.cornerRadius = 12
        layer.borderWidth = 0.3
        layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.1
    }
}

class LightShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.borderWidth = 0.3
        layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.05
    }
}

class LightPresenShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.masksToBounds = false
        layer.cornerRadius = 15
        layer.borderWidth = 0.3
        layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.05
    }
}

class QuoteView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.borderWidth = 0.3
        layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.05
    }
}

class ShadowImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
