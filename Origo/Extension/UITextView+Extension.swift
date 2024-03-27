//
//  UITextView+Extension.swift
//  Hammer Parking
//
//  Created by yapapp on 28/10/22.
//

import UIKit

extension UITextView{
    
    func setTxtViewText(){
        text = LocalizedStringEnum.writeHere.localized
    }
    
}

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let superview = view.superview {
            let child = superview.convert(view.frame, to: self)
            let visible = CGRect(origin: contentOffset, size: visibleSize)
            let newOffsetY = child.minY < visible.minY ? child.minY : child.maxY > visible.maxY ? child.maxY - visible.height : nil
            if let y = newOffsetY {
                setContentOffset(CGPoint(x:0, y: y), animated: animated)
            }
        }
    }

}
