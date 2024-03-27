//
//  ReportOutfitsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 29/02/24.
//

import UIKit

class ReportOutfitsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)

    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
