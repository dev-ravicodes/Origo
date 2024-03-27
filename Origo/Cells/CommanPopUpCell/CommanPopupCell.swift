//
//  CommanPopupCell.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 16/02/24.
//

import UIKit

class CommanPopupCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    
    let nibName = "CommonPopupCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        self.loadViewFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
