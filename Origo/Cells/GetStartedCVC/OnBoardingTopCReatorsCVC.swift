//
//  OnBoardingTopCReatorsCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/02/24.
//

import UIKit

class OnBoardingTopCReatorsCVC: UICollectionViewCell {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(OnBoardingTVC.self)
        }
    }
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var itemNameImg: UIImageView!
    
    var item: TopCreatorsData?
    
    
    //MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //MARK: - Convenience
    func configData(_ item: WelcomeData) {
        lblDesc.text = item.itemDesc
        itemNameImg.image = UIImage(named: item.itemNameImage)
    }
    
}


//MARK: - UITableViewDataSource Methods
extension OnBoardingTopCReatorsCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: OnBoardingTVC.self, for: indexPath)
        cell.configData(item ?? TopCreatorsData())
        
        return cell
    }
    
}
