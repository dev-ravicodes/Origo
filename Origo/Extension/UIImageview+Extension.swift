//
//  UIImageview+Extension.swift
//  Hammer Parking
//
//  Created by yapapp on 10/20/22.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    
    func circular(){
        layer.cornerRadius = frame.size.height / 2
    }
    
    func setImageWithKF(_ imageURLString: String?,isPlaceHolder:Bool?=true,placeHolderStr:String?=nil, completion: ((UIImage?) -> ())? = nil) {
        if let imageURL = imageURLString,
            let url = URL(string: imageURL) {
            let resource = KF.ImageResource(downloadURL: url)
            var kf = self.kf
            kf.indicatorType = .activity
            var placeHolderImage = UIImage()
            if isPlaceHolder == true{
                var placeHolderString = ""
                if placeHolderStr?.trim().count ?? 0 > 0{
                    placeHolderString = placeHolderStr ?? ""
                }else{
                    placeHolderString = "user_image"
                }
                placeHolderImage = UIImage(named: placeHolderString) ?? UIImage()
            }
//            kf.setImage(with: resource, placeholder: placeHolderImage, options: [.transition(.fade(1)), .forceRefresh], completionHandler: { result in
            kf.setImage(with: resource, placeholder: placeHolderImage, options: [.transition(.fade(1)), .cacheOriginalImage], completionHandler: { result in
                switch result {
                case .success(let imageResult):
                    let image = imageResult.image
                    self.image = image
                    completion?(image)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion?(nil)
                }
            })
        }else {
            completion?(nil)
        }
    }
    
    ///Firstly download & show the thumbnail on image view from the given thunbnailUrlString. After that automatically download & show the image from the imageUrlString.
    func setImageWith(thunbnailUrlString: String?, imageUrlString: String?, completion: ((Bool) -> ())? = nil) {

        if let urlString = thunbnailUrlString, urlString != "" {
            guard let url = URL.init(string: urlString) else {
                return
            }
            let resource = Kingfisher.ImageResource(downloadURL: url)
            var kf = self.kf
            kf.indicatorType = .activity
            self.kf.setImage(with: resource, placeholder: #imageLiteral(resourceName: "placeholderImage"), options: [.transition(.fade(1)), .cacheOriginalImage]){ [weak self] (result) in
                switch result {
                    
                case .success(_):
                    if let urlString = imageUrlString, urlString != "" {
                        self?.getFullImageAndSet(with: urlString) { [weak self] (image) in
                            completion?(true)
                        }
                    }else {
                        completion?(true)
                    }
                case .failure(_):
                    completion?(false)
                }
            }
        }else if let urlString = imageUrlString, urlString != "" {
            self.getFullImageAndSet(with: urlString) { [weak self] (image) in
                completion?(true)
            }
        }else {
            completion?(false)
        }
    }
    
    private func getFullImageAndSet(with urlString: String, completion: @escaping (UIImage?) -> ()) {

        if urlString == "" {
            return
        }
        
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = Kingfisher.ImageResource(downloadURL: url)
        let tempImageView = UIImageView()
        tempImageView.kf.setImage(with: resource, options: [.cacheOriginalImage]){ (result) in
            switch result {
                
            case .success(_):
                completion(tempImageView.image)
                if let image = tempImageView.image {
                    UIView.transition(with: self, duration: 0.50, options: .transitionCrossDissolve, animations: {
                        self.image = image
                    }, completion: nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            let hScale = newSize.height / size.height
            let vScale = newSize.width / size.width
            let scale = max(hScale, vScale) // scaleToFill
            let resizeSize = CGSize(width: size.width*scale, height: size.height*scale)
            var middle = CGPoint.zero
            if resizeSize.width > newSize.width {
                middle.x -= (resizeSize.width-newSize.width)/2.0
            }
            if resizeSize.height > newSize.height {
                middle.y -= (resizeSize.height-newSize.height)/2.0
            }
            
            draw(in: CGRect(origin: middle, size: resizeSize))
        }
    }
    
    
}


@IBDesignable
class DynamicImageView: UIImageView {

    @IBInspectable var fixedWidth: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    @IBInspectable var fixedHeight: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        var size = CGSize.zero
        if fixedWidth > 0 && fixedHeight > 0 { // 宽高固定
            size.width = fixedWidth
            size.height = fixedHeight
        } else if fixedWidth <= 0 && fixedHeight > 0 { // 固定高度动态宽度
            size.height = fixedHeight
            if let image = self.image {
                let ratio = fixedHeight / image.size.height
                size.width = image.size.width * ratio
            }
        } else if fixedWidth > 0 && fixedHeight <= 0 { // 固定宽度动态高度
            size.width = fixedWidth
            if let image = self.image {
                let ratio = fixedWidth / image.size.width
                size.height = image.size.height * ratio
            }
        } else { // 动态宽高
            size = image?.size ?? .zero
        }
        return size
    }

}

import UIKit
import ImageIO
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}



extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL? = URL(string: gifUrl)
        else {
            print("image named \"\(gifUrl)\" doesn't exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL!) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
}

extension UIImage {
    func addFilter(filter : FilterType) -> UIImage {
        let filter = CIFilter(name: filter.rawValue)
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        //Return the image
        return UIImage(cgImage: cgImage!)
    }
}
