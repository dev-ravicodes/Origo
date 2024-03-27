//
//  OverlayView.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 05/03/24.
//

import UIKit
import Koloda

private let overlayRightImageName = "ic_OverlayImg"
private let overlayLeftImageName = "ic_NextAnimation"

class OutfitsOverlayView: OverlayView {
    
    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        return imageView
    }()
    
    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .left? :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }
    
}
