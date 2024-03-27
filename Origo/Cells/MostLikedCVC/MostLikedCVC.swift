//
//  MostLikedCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import UIKit

class MostLikedCVC: UICollectionViewCell {
    
    @IBOutlet weak var fitsImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configView()
    }
    
    private func configView() {
        self.contentView.addBottomShadow()
    }
    
    func configMostLikedOutfits(_ item: MostLikedOutfit?) {
        if let outfitImgs = item?.outfitImages {
            guard let outfitImg = outfitImgs.first else {return}
            if !outfitImg.isBlank {
                self.fitsImgView.setImageWithKF(outfitImg)
            }
        }
    }
    
    func configData(_ image: String?) {
        var fitsImage = image ?? ""
        if !fitsImage.isBlank {
            self.fitsImgView.setImageWithKF(fitsImage)
        }
    }
    
}
