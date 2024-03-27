//
//  MenuTVC.swift
//  Origo
//
//  Created by iTechnolabs on 14/03/24.
//

import UIKit

class OptionTVC: UITableViewCell {

    @IBOutlet weak var optionLbl: UILabel!
    
    @IBOutlet weak var iBtn: UIButton!
    var buttonAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(option: String){
        optionLbl.text = option
    }
    
    @IBAction func infoBtnTapped(_ sender: UIButton) {
        buttonAction?()
       }
    
}
