//
//  AddRackCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/03/24.
//

import UIKit

class AddRackCVC: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.white
        
        // Add shadow
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: -5, height: 5) // Adjust the values for the desired shadow direction
        contentView.layer.shadowRadius = 5
        contentView.layer.masksToBounds = false
    }
    
}
