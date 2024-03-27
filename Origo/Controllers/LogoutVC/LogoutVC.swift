//
//  LogoutVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 04/03/24.
//

import UIKit

class LogoutVC: UIViewController {
    
    var onYes: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func noAction(_sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func yesAction(_sender: UIButton) {
        self.dismiss(animated: true) {
            self.onYes?()
        }
    }

}
