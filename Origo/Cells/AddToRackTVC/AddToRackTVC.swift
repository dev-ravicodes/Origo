//
//  AddToRackTVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 15/03/24.
//

import UIKit

class AddToRackTVC: UITableViewCell {

    
    @IBOutlet weak var rackLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configCell(_ item: AllRacksWithoutPrimaryData?) {
        rackLbl.text = item?.name?.capitalized
    }
    
}
