//
//  CustomButton.swift
//  JiuJitsu
//
//  Created by iTechnolabs - 7 on 26/12/23.
//

import UIKit

class CustomButton: UIButton {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        titleLabel?.font = UIFont.urbanistSemiBold(ofSize: 16.0)
        layer.cornerRadius = 10
        backgroundColor = UIColor.buttonBG
        setTitleColor(.white, for: .normal)
        layer.masksToBounds = true
    }
}
