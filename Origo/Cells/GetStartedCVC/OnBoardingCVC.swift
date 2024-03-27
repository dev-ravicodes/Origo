//
//  OnBoardingCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/02/24.
//

import UIKit

class OnBoardingCVC: UICollectionViewCell {
    
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var itemNameImg: UIImageView!
    @IBOutlet weak var leadingImgConstarint: NSLayoutConstraint!
    @IBOutlet weak var tralingImgConstrait: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configData(_ item: WelcomeData) {
        itemImg.image = UIImage(named: item.itemImage)
        if item .itemDesc == "My Rack" {
            self.leadingImgConstarint.constant = 110
            self.tralingImgConstrait.constant = 110
            let fullString = NSMutableAttributedString(string:"Swipe right to like an outfit, left for the next one. Press \"Hang\" ")
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "ic_hanger")
            image1Attachment.bounds = CGRect(x: 0, y: -4, width: 22, height: 18)
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
            fullString.append(NSAttributedString(string:" to save favorites to your \"My Rack\"."))
            self.lblDesc.attributedText = fullString
        } else {
            lblDesc.text = item.itemDesc
            self.leadingImgConstarint.constant = 0
            self.tralingImgConstrait.constant = 0
        }
        itemNameImg.image = UIImage(named: item.itemNameImage)
    }

}
