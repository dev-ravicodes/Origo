//
//  OutfitdetailsCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 15/03/24.
//

import UIKit

class OutfitItemsdetailsCVC: UICollectionViewCell {
    
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
        let imgURL = item?.image.first ?? ""
        if !(imgURL.isBlank) {
            outfitImg.setImageWithKF(imgURL)
        }
    }
    
    func configCellPreview(_ item: AddOutfitDetailItems?) {
//        mainView.backgroundColor = item?.isSelected == true ? .lightGreyBackground : .white
        outfitsLBl.text = "\(item?.type ?? "")"
        matiralNameLbl.text = item?.brand ?? ""
//        outfitsLBl.backgroundColor = .red
//        matiralNameLbl.backgroundColor = .green
        let imgURL = item?.image?.first ?? ""
        if !(imgURL.isBlank) {
            outfitImg.setImageWithKF(imgURL)
        }
    }
    
}
