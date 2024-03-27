//
//  OutfitCollectionCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 14/03/24.
//

import UIKit

class OutfitCollectionCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var removeBtn: UIButton!
    var onRemove: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func removeOutfitAction(_ sender: UIButton) {
        self.onRemove?()
    }
    
    func configUI(img: UIImage) {
        imgView.image = img
        
    }
    
}
