//
//  CustomKolodaView.swift
//  Origo
//
//  Created by iTechnolabs MAC MIINI 11 on 06/03/24.
//

import UIKit
import Koloda


class CustomKolodaView: KolodaView {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
    }
    
    
//    @objc func panGestureRecognized(gestureRecognizer: UIPanGestureRecognizer) {
//        xDistanceFromCenter = gestureRecognizer.translationInView(self).x
//        yDistanceFromCenter = gestureRecognizer.translationInView(self).y
//
//        let touchLocation = gestureRecognizer.location(in: self)
//        switch gestureRecognizer.state {
//        case .began:
//            originalLocation = center
//
//            animationDirection = touchLocation.y >= frame.size.height / 2 ? -1.0 : 1.0
//            layer.shouldRasterize = true
//            break
//
//        case .changed:
//
//            let rotationStrength = min(xDistanceFromCenter! / self.frame.size.width, rotationMax)
//            let rotationAngle = animationDirection! * defaultRotationAngle * rotationStrength
//            let scaleStrength = 1 - ((1 - scaleMin) * fabs(rotationStrength))
//            let scale = max(scaleStrength, scaleMin)
//
//            layer.rasterizationScale = scale * UIScreen.mainScreen().scale
//     
//            let transform = CGAffineTransformMakeRotation(rotationAngle)
//            let scaleTransform = CGAffineTransformScale(transform, scale, scale)
//
//            self.transform = scaleTransform
//            center = CGPoint(x: originalLocation!.x + xDistanceFromCenter!, y: originalLocation!.y + yDistanceFromCenter!)
//               
//            updateOverlayWithFinishPercent(xDistanceFromCenter! / frame.size.width)
//            //100% - for proportion
//            delegate?.cardDraggedWithFinishPercent(self, percent: min(fabs(xDistanceFromCenter! * 100 / frame.size.width), 100))
//
//            break
//        case .Ended:
//            swipeMadeAction()
//
//            layer.shouldRasterize = false
//        default:
//            break
//        }
//    }
    
}
