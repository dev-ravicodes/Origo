//
//  SectionHeaderView.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 26/02/24.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    
    //MARK: - Intrface Builder Outlets
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var moreOPtionBtn: UIButton!
    
    
    var onOption: (()->())?
    
    //MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func moreOPtionAction(_ sender: UIButton) {
        onOption?()
    }
}
