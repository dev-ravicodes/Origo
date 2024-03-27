//
//  ConfirmOutfitGuideLines.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 13/03/24.
//

import UIKit

class ConfirmOutfitGuideLines: UIViewController {

    
    var onConfirm: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func msgShowAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        AppCache.shared.showGuidelines = sender.isSelected
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.onConfirm?()
        }
        
    }
    
    @IBAction func dissmissAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
