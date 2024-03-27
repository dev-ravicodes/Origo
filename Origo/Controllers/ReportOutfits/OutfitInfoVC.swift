//
//  OutfitInfoVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/03/24.
//

import UIKit

class OutfitInfoVC: UIViewController {
    
    @IBOutlet weak var infoImage: UIImageView!
    
    var viaUploadOutfit = false
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viaUploadOutfit{
            infoImage.image = UIImage.init(named: imageName)
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true)
        }
    }
   
}
