//
//  MoreOptionsTVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 29/02/24.
//

import UIKit

struct Options {
    var image: String
    var title: String
}

class MoreOptionsTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configCell(_ item: Options) {
        imgView.image = UIImage(named: item.image)
        titleLbl.text = item.title
    }

}
