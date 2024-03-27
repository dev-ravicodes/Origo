//
//  FitCheckInfoVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 12/03/24.
//

import UIKit

class FitCheckInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true)
        }
    }

}
