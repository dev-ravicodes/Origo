//
//  ChatVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 12/03/24.
//

import UIKit

class ChatVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var tablView: UITableView! {
        didSet {
            self.tablView.registerNib(ChatTVC.self)
            self.tablView.rowHeight = UITableView.automaticDimension
        }
    }
    
    
    //MARK: - View Life Cycyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


//MARK: - UITableViewDataSource & UITableViewDelegate Methods
extension ChatVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: ChatTVC.self, for: indexPath)
        
        return cell
    }
    
}
