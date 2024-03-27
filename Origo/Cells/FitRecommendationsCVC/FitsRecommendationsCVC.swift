//
//  FitsRecommendationsCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/02/24.
//

import UIKit
import Kingfisher

class FitsRecommendationsCVC: UICollectionViewCell {
    
    @IBOutlet weak var fitsImgView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var removeBtn: UIButton!
    
    private var longPressGestureRecognizer: UILongPressGestureRecognizer!
    var selectionHandler:(()->())?
    var onRemove:(()->())?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configView()
    }
    
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            selectionHandler?()
        }
    }
    
    
    private func configView() {
        fitsImgView.layer.shadowColor = UIColor.black.cgColor
        fitsImgView.layer.shadowOpacity = 0.2
        fitsImgView.layer.shadowOffset = CGSize(width: 0, height: 4)
        fitsImgView.layer.shadowRadius = 2
        fitsImgView.layer.masksToBounds = false
        fitsImgView.layer.shouldRasterize = true
        fitsImgView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func configData(_ item: FitsItems?) {
        let outfitImg = item?.image
        if !(outfitImg?.isBlank ?? false) {
            self.fitsImgView.setImageWithKF(outfitImg)
        }
        mainView.isHidden = item?.isSelected == true ? false : true
    }
    
    func configData(_ item: Outfit?) {
        if let outfitImg = item?.outfitImages {
            if !(outfitImg[0].isBlank ) {
                self.fitsImgView.setImageWithKF(outfitImg[0])
            }
        }
        mainView.isHidden = item?.isSelected == true ? false : true
    }
    
        
    func configOutfitsData(_ item: OutfitsItems?) {
        let outfitImg = item?.items.first?.image.first ?? ""
        if item?.addGesture == true {
            longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            self.addGestureRecognizer(longPressGestureRecognizer)
        }
        if let outfitImg = item?.outfitImages {
            if !(outfitImg[0].isBlank) {
                let options: KingfisherOptionsInfo = [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0)),
                    .cacheOriginalImage
                ]
                self.fitsImgView.kf.setImage(with: URL(string: outfitImg[0]), options: options)
            }
        }
        removeBtn.isHidden = item?.iSelected == true ? false : true
    }
    
    @IBAction func removeBtnAction(_ sender: Any) {
        self.onRemove?()
    }
    
}
