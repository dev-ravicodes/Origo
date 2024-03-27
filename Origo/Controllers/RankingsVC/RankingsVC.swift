//
//  RankingsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 12/03/24.
//

import UIKit

class RankingsVC: UIViewController {
    
    
    @IBOutlet weak var tablView: UITableView! {
        didSet {
            self.tablView.registerNib(OnBoardingTVC.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}


//MARK: - UITableViewDataSource & UITableViewDelegate Methods
extension RankingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: OnBoardingTVC.self, for: indexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}
