//
//  OnBoardingTVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/02/24.
//

import UIKit

class OnBoardingTVC: UITableViewCell {
    
    @IBOutlet weak var creatorImg: UIImageView!
    @IBOutlet weak var creatorNameLbl: UILabel!
    @IBOutlet weak var creatorOutfitsCountLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configData(_ item: TopCreatorsData) {
        let creatorImg = item.avatar
        if !(creatorImg?.isBlank ?? false) {
            self.creatorImg.setImageWithKF(creatorImg)
        }
        self.creatorNameLbl.text = item.name
        self.creatorOutfitsCountLbl.text = item.outfitCount
    }
    
}
