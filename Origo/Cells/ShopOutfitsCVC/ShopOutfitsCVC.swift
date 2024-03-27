//
//  ShopOutfitsCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 21/02/24.
//

import UIKit

class ShopOutfitsCVC: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var outfitImg: UIImageView!
    @IBOutlet weak var outfitsLBl: UILabel!
    @IBOutlet weak var matiralNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemLbl.isHidden = true
    }
    
    func configCell(_ item: Item?) {
        mainView.backgroundColor = item?.isSelected == true ? .lightGreyBackground : .white
        outfitsLBl.text = "\(item?.type ?? "")"
        matiralNameLbl.text = item?.brand ?? ""
//        outfitsLBl.backgroundColor = .red
//        matiralNameLbl.backgroundColor = .green
        let imgURL = item?.image.first ?? ""
        if !(imgURL.isBlank) {
            outfitImg.setImageWithKF(imgURL)
        }
    }

}
