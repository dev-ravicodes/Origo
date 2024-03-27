//
//  CompletedResetPasswordVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

class CompletedResetPasswordVC: UIViewController {

    var onLogin: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func continueAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: self.onLogin)
    }

}
