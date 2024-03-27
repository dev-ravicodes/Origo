//
//  InfoVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 15/02/24.
//

import UIKit

class InfoVC: UIViewController {
    
    @IBOutlet weak private var descLabel: UILabel!
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet weak private var containerView: UIView!
    
    var descText = "Select whether you are signing up as an individual user or on behalf of a business or organization."
    var frameY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descLabel.text = self.descText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true)
        }
    }
}

