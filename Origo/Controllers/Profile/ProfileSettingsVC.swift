//
//  ProfileSettingsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 04/03/24.
//

import UIKit

class ProfileSettingsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(ProfileSettingsTVC.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.popVC()
    }

}

extension ProfileSettingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        17
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: ProfileSettingsTVC.self, for: indexPath)
        cell.configData(indexPath.row)
        cell.onPause = { [weak self] in
            let vc = ScreenManager.getController(storyboard: .authentication, controller: InfoVC.self)
            vc.modalPresentationStyle = .overCurrentContext
            vc.descText = "Your outfits won’t appear in the explore section but you will still be able to see your racks and highlights."
            self?.present(vc, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 15 {
            let vc = ScreenManager.getController(storyboard: .profile, controller: LogoutVC.self)
            vc.modalPresentationStyle = .overCurrentContext
            vc.onYes = {[weak self] in
                let vc = ScreenManager.getController(storyboard: .authentication, controller: LoginVC.self)
                AppCache.shared.newUser = false
                AppCache.shared.removeAllUserDefaults()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            self.present(vc, animated: true)
        }
    }
    
}
