//
//  Gradient Button.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import UIKit

class ActualGradientButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame.size = frame.size
        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 20)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        
        if gradientLayer.superlayer == nil {
            gradientLayer.frame.size = frame.size
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 2.5, y: 0.5)
    //        l.locations = [0.0,1.0]
            gradientLayer.cornerRadius = 22
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}

class BlueButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 20)
        layer.cornerRadius = 22
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }

}

class WhiteGradientButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame.size = frame.size
        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 20)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        if gradientLayer.superlayer == nil {
            gradientLayer.frame.size = frame.size
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 2.5, y: 0.5)
    //        l.locations = [0.0,1.0]
            gradientLayer.cornerRadius = 22
            gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor]
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }

}

class ColoredGradientButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame.size = frame.size
        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 20)
        
//        let yellowColor = UIColor(red: 0.975, green: 0.717, blue: 0.053, alpha: 1)
//        setTitleColor(yellowColor, for: .normal)
//
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        if gradientLayer.superlayer == nil {
            gradientLayer.frame.size = frame.size
//            gradientLayer.borderWidth = 2
//            gradientLayer.borderColor = yellowColor.cgColor
            gradientLayer.cornerRadius = 20
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }

}

class ColoredGradientSmallButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame.size = frame.size
        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 12)
        
//        let yellowColor = UIColor(red: 0.975, green: 0.717, blue: 0.053, alpha: 1)
//        setTitleColor(yellowColor, for: .normal)
//
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        if gradientLayer.superlayer == nil {
            gradientLayer.frame.size = frame.size
//            gradientLayer.borderWidth = 2
//            gradientLayer.borderColor = UIColor.black.cgColor
            gradientLayer.cornerRadius = 10
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }

}

class DeleteBlueButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame.size = frame.size
        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 15)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        if gradientLayer.superlayer == nil {
            gradientLayer.frame.size = frame.size
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 2.5, y: 0.5)
            gradientLayer.cornerRadius = 18
        }
    }
}

class DeleteWhiteButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame.size = frame.size
        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 15)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        if gradientLayer.superlayer == nil {
            gradientLayer.frame.size = frame.size
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 2.5, y: 0.5)
            gradientLayer.cornerRadius = 18
            gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor]
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}

class GreenButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 20)
        layer.cornerRadius = 22
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
    }

}
