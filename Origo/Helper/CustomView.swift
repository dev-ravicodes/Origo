//
//  CustomView.swift
//  JiuJitsu
//
//  Created by iTechnolabs - 7 on 28/12/23.
//

import UIKit

class CustomView: UIView {
    var radius: CGFloat = 46
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Create a path with the semi-circle
        let semiCirclePath = UIBezierPath(
            arcCenter: CGPoint(
                x: bounds.midX,
                y: bounds.maxY
            ),
            radius: radius,
            startAngle: -.pi,
            endAngle: 0,
            clockwise: true
        )
        
        semiCirclePath.addArc(
            withCenter: CGPoint(x: bounds.midX - radius, y: bounds.maxY),
            radius: 10.0,
            startAngle: 0,
            endAngle: .pi / 2,
            clockwise: true
        )
        
        // Create a path for the rounded rectangle
        let roundedRectPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        // Append the semi-circle path
        roundedRectPath.append(semiCirclePath)
        
        // Create a shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = roundedRectPath.cgPath
        
        // Set the fill rule - this allows the rectangle to be filled and the semi-circle to be removed
        shapeLayer.fillRule = .evenOdd
        
        // Apply the shape layer as the mask
        layer.mask = shapeLayer
    }
}
