//
//  UIButton+Extension.swift
//  Supervisor
//
//  Created by yapapp on 10/27/22.
//

import UIKit
import Kingfisher

extension UIButton {
    /// 0 => .ScaleToFill
    /// 1 => .ScaleAspectFit
    /// 2 => .ScaleAspectFill
    @IBInspectable
    var imageContentMode: Int {
        get {
            return self.imageView?.contentMode.rawValue ?? 0
        }
        set {
            if let mode = UIView.ContentMode(rawValue: newValue),
                self.imageView != nil {
                DispatchQueue.main.async {
                    self.imageView?.contentMode = mode
                }
            }
        }
    }
    
    func setImageWithKF(_ imageURLString: String?,placeholder:String?=nil) {
        if let imageURL = imageURLString,
           let url = URL(string: imageURL) {
            let resource = Kingfisher.ImageResource(downloadURL: url)
            let kf = self.kf
            kf.setImage(with: resource,for: .normal, placeholder:UIImage(named: placeholder ?? ""), options: [.forceRefresh,.progressiveJPEG(ImageProgressive())])
        }
    }
    
    func setImageKF(_ imageURLString: String?,placeholder:String?=nil) {
        if let imageURL = imageURLString,
           let url = URL(string: imageURL) {
            let resource = Kingfisher.ImageResource(downloadURL: url)
            let kf = self.kf
            kf.setImage(with: resource,for: .normal, placeholder:UIImage(named: placeholder ?? ""), options: [.progressiveJPEG(ImageProgressive())])
        }
    }
}

class CircleButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
        layer.masksToBounds = true
    }

}

class CircleImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
        layer.masksToBounds = true
    }

}
