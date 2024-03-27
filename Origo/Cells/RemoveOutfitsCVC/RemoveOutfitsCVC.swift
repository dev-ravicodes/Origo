//
//  RemoveOutfitsCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/03/24.
//

import UIKit

class RemoveOutfitsCVC: UICollectionViewCell {

    @IBOutlet weak var fitsImgView: UIImageView!
    @IBOutlet weak var removeBtn: UIButton!

    var onRemove: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    @IBAction func removeOutfitsAction(_sender: UIButton) {
        self.onRemove?()
    }
    
//    func configHighLightDetailsCell(_ item: String?) {
//        let imgURL = item ?? ""
//        if !(imgURL.isBlank) {
//            fitsImgView.setImageWithKF(imgURL)
//        }
//
//    }
    
    func configDetailsCell(_ item: [String]?) {
        if let imgURL = item?.first {
            let url = imgURL
            if !(url.isBlank) {
                fitsImgView.setImageWithKF(imgURL)
            }
        }
        
    }
    
}
