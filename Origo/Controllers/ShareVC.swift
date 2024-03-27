//
//  ShareVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/03/24.
//

import UIKit

class ShareVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.registerNib(SharePeopleTVC.self)
        }
    }
    @IBOutlet weak var tableVIewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                self.dismiss(animated: true)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        tableVIewHeight.constant = tableView.contentSize.height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: SharePeopleTVC.self, for: indexPath)
        if indexPath.row == 1 {
            cell.shareImg.isHidden = false
        }
        
        return cell
    }
    

}
