//
//  AccountTypeVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

enum AccountType: String {
    case Individual = "individual"
    case Business = "business"
}

class AccountTypeVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var businessBtn: UIButton!
    @IBOutlet weak var individualBtn: UIButton!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var detailsView: UIView!
    
    
    //MARK: - Variables
    var account: AccountType = .Individual {
        didSet {
            self.configButtons()
        }
    }
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.detailsView.isHidden = true
    }
    
    
    //MARK: - Convenience
    private func configButtons() {
        if account == .Individual {
            businessBtn.backgroundColor = .white
            businessBtn.setTitleColor(.buttonBG, for: .normal)
            individualBtn.backgroundColor = .accountTypeBg
            individualBtn.setTitleColor(.white, for: .normal)
        } else {
            businessBtn.backgroundColor = .accountTypeBg
            businessBtn.setTitleColor(.white, for: .normal)
            individualBtn.backgroundColor = .white
            individualBtn.setTitleColor(.buttonBG, for: .normal)
        }
    }
    
    private func configUI() {
        let fullString = NSMutableAttributedString(string: "Choose the account type that best fits you. ")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "ic_detailsIcon")
        let newSize = CGRect(x: 0, y: -3.2, width: 18, height: 18)
        imageAttachment.bounds = newSize
        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(imageString)
        lblAccount.attributedText = fullString
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showBlurbMessage(tapGesture:)))
        self.lblAccount.addGestureRecognizer(tapGesture)
    }
 
    
    //MARK: - Objc Methods
    @objc func showBlurbMessage(tapGesture: UITapGestureRecognizer) {
        let location = (lblAccount.text?.count ?? 0)
        self.showInfoPoup(sender: lblAccount, text: "Select whether you are signing up as an individual user or on behalf of a business or organization.")
    }
    
    private func showInfoPoup(sender: UILabel, text: String) {
        let vc = ScreenManager.getController(storyboard: .authentication, controller: InfoVC.self)
        vc.descText = text
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func individualBtnAction(_ sender: UIButton) {
        account = .Individual
    }
    
    @IBAction func businessBtnAction(_ sender: UIButton) {
        account = .Business
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        if account == .Business {
            let nextVC = ScreenManager.getController(storyboard: .authentication, controller: SingUpBussinessVC.self)
            nextVC.accountType = account.rawValue
            nextVC.viewModel.accountType = .Business
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let nextVC = ScreenManager.getController(storyboard: .authentication, controller: SignUpIndividualVC.self)
            nextVC.accountType = account.rawValue
            nextVC.viewModel.accountType = .Individual
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .authentication, controller: LoginVC.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
