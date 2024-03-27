//
//  ProfileSettingsTVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 04/03/24.
//

import UIKit


class ProfileSettingsTVC: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet weak var detailIcon: UIButton!
    @IBOutlet weak var switchControll: UISwitch!
    
    var onEdit: (()->())?
    var onPause: (()->())?
    var onSwitch: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        self.onEdit?()
    }
    
    @IBAction func pauseAccountDetialAction(_ sender: UIButton) {
        self.onPause?()
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        self.onSwitch?()
    }
    
    func configData(_ item: Int) {
        if item == 0 {
            titleLbl.text  = "Name"
            titleLbl.textColor = UIColor.lightGray
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = true
            detailIcon.isHidden = true
            switchControll.isHidden = true
        }
        else if item == 1 {
            titleLbl.text  = "Jodle"
            arrowBtn.setImage(UIImage(named: "ic_arrowProfileSetting"), for: .normal)
            arrowBtn.setTitle("", for: .normal)
            titleLbl.textColor = UIColor.buttonBGColor
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = false
            detailIcon.isHidden = true
            switchControll.isHidden = true
            
        }else if item == 2 {
            titleLbl.text  = "Phone & email"
            titleLbl.textColor = UIColor.lightGray
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = true
            detailIcon.isHidden = true
            switchControll.isHidden = true
            
        }
        else if item == 3 {
            titleLbl.text  = "+123456878"
            arrowBtn.setImage(UIImage(named: "ic_arrowProfileSetting"), for: .normal)
            arrowBtn.setTitle("", for: .normal)
            titleLbl.textColor = UIColor.buttonBGColor
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = false
            detailIcon.isHidden = true
            switchControll.isHidden = true
            
        }
        else if item == 4 {
            titleLbl.text  = "joidgi@origo.com"
            arrowBtn.setTitle("edit", for: .normal)
            arrowBtn.setImage(nil, for: .normal)
            titleLbl.textColor = UIColor.buttonBGColor
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = false
            detailIcon.isHidden = true
            switchControll.isHidden = true
            
        }
        else if item == 5 {
            titleLbl.text  = "Verify Your Email"
            arrowBtn.setImage(UIImage(named: "ic_arrowProfileSetting"), for: .normal)
            titleLbl.textColor = UIColor.buttonBGColor
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = false
            detailIcon.isHidden = true
            switchControll.isHidden = true
            
        }else if item == 6 {
            titleLbl.text  = "Notifications"
            titleLbl.textAlignment = .left
            titleLbl.textColor = UIColor.lightGray
            arrowBtn.isHidden = true
            detailIcon.isHidden = true
            switchControll.isHidden = true
        }
        else if item == 7 {
            arrowBtn.setImage(UIImage(named: "ic_arrowProfileSetting"), for: .normal)
            arrowBtn.setTitle("", for: .normal)
            titleLbl.text  = "Push Notifications"
            titleLbl.textColor = UIColor.buttonBGColor
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = false
            detailIcon.isHidden = true
            switchControll.isHidden = true
            
        } else if item == 8{
            arrowBtn.setImage(UIImage(named: "ic_arrowProfileSetting"), for: .normal)
            arrowBtn.setTitle("", for: .normal)
            titleLbl.text  = "Email"
            titleLbl.textColor = UIColor.buttonBGColor
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = false
            detailIcon.isHidden = true
            switchControll.isHidden = true
        }else if item == 9 {
            titleLbl.text  = "Legal"
            titleLbl.textColor = UIColor.lightGray
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = true
            detailIcon.isHidden = true
            switchControll.isHidden = true
            
        }else if item == 10 {
            arrowBtn.setImage(UIImage(named: "ic_arrowProfileSetting"), for: .normal)
            arrowBtn.setTitle("", for: .normal)
            titleLbl.text  = "Privacy Policy"
            titleLbl.textColor = UIColor.buttonBGColor
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = false
            detailIcon.isHidden = true
            switchControll.isHidden = true
        }
        else if item == 11{
            arrowBtn.setImage(UIImage(named: "ic_arrowProfileSetting"), for: .normal)
            arrowBtn.setTitle("", for: .normal)
            titleLbl.text  = "Terms Of Service"
            titleLbl.textColor = UIColor.buttonBGColor
            titleLbl.textAlignment = .left
            arrowBtn.isHidden = false
            detailIcon.isHidden = true
            switchControll.isHidden = true
        }
        else if item == 12{
            titleLbl.text  = ""
            arrowBtn.isHidden = true
            arrowBtn.isHidden = true
            detailIcon.isHidden = true
            switchControll.isHidden = true
        }
        else if item == 13{
            titleLbl.text  = "Contact Customer Support"
            titleLbl.textAlignment = .center
            titleLbl.textColor = UIColor.buttonBGColor
            arrowBtn.isHidden = true
            detailIcon.isHidden = true
            switchControll.isHidden = true
        }
        else if item == 14{
            titleLbl.text  = "Pause Account"
            titleLbl.textAlignment = .center
            titleLbl.textColor = UIColor.buttonBGColor
            arrowBtn.isHidden = true
            detailIcon.isHidden = false
            switchControll.isHidden = false
        }
        else if item == 15{
            titleLbl.text  = "Log Out"
            titleLbl.textAlignment = .center
            titleLbl.textColor = UIColor.buttonBGColor
            arrowBtn.isHidden = true
            detailIcon.isHidden = true
            switchControll.isHidden = true
        }
        else if item == 16{
            arrowBtn.isHidden = true
            detailIcon.isHidden = true
            switchControll.isHidden = true
            titleLbl.text  = "Delete Account"
            titleLbl.textAlignment = .center
            titleLbl.textColor = UIColor.buttonBGColor
        }
    }
}
