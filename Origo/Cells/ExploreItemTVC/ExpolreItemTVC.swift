//
//  ExpolreItemTVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/03/24.
//

import UIKit

class ExpolreItemTVC: UITableViewCell {

    @IBOutlet weak var itemLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ item: Item?) {
        itemLbl.text = "\(item?.type ?? ""), \(item?.color ?? ""), \(item?.brand ?? ""),  \(item?.material ?? ""), \(item?.model ?? "")"
    }
    
    func configCellPreview(_ item: AddOutfitDetailItems?) {
        if let model = item?.model{
            itemLbl.text = "\(item?.type ?? ""), \(item?.color ?? ""), \(item?.brand ?? ""), \(item?.material ?? ""), \(model)"
        }else{
            itemLbl.text = "\(item?.type ?? ""), \(item?.color ?? ""), \(item?.brand ?? ""), \(item?.material ?? "")"
        }
    }

}
