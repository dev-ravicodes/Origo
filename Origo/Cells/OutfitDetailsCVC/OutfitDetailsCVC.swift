//
//  OutfitDetailsCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/03/24.
//

import UIKit

class OutfitDetailsCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configDetailsCell(_ item: String?) {
        let imgURL = item ?? ""
        if !(imgURL.isBlank) {
            imgView.setImageWithKF(imgURL)
        }
    }
}
