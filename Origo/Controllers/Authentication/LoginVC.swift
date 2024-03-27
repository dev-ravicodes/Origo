//
//  LoginVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

class LoginVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var emailBgView: UIView!
    @IBOutlet weak var passBgView: UIView!
    @IBOutlet weak var emailImg: UIImageView!
    @IBOutlet weak var passImg: UIImageView!
    @IBOutlet weak var emialTf: UITextField!
    @IBOutlet weak var passTf: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var rememberBtn: UIButton!
    
    
    //MARK: - Variables
    var viewModel = LoginVM()
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let loginDetails = AppCache.shared.savedLoginDetails {
            DispatchQueue.main.async {
                self.emialTf.text = loginDetails.email ?? ""
                self.passTf.text = loginDetails.password ?? ""
                self.rememberBtn.isSelected = (AppCache.shared.rememberMe == true)
            }
        }
    }
    
    
    //MARK: - Convenience
    private func configData() {
        
    }
    
    private func prepareRequestModel() {
        self.viewModel.requestModel.email = self.emialTf.text ?? ""
        self.viewModel.requestModel.password = self.passTf.text ?? ""
        AppCache.shared.rememberMe = rememberBtn.isSelected
        if rememberBtn.isSelected {
            let model = self.viewModel.requestModel
            AppCache.shared.savedLoginDetails = LoginRequestModel(email: model.email, password: model.password)
        } else {
            AppCache.shared.savedLoginDetails = nil
        }
        self.authenticateUser()
    }
    
    private func toggleSecureTextEntry(for textField: UITextField, eyeButton: UIButton) {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? AppConstants.hidePass : AppConstants.showPass
        if let image = UIImage(named: imageName) {
            eyeButton.setImage(image, for: .normal)
        } else {
            print("Error: Unable to load image named \(imageName)")
        }
    }

    
    //MARK: - Interface Builder Actions
    @IBAction func passEyeBtnAction(_ sender: UIButton) {
        toggleSecureTextEntry(for: passTf, eyeButton: passEyeBtn)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        self.prepareRequestModel()
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .authentication, controller: ForgotPasswordVC.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @IBAction func rememberAction(_ sender: UIButton) {
        rememberBtn.isSelected.toggle()
        let imageName = rememberBtn.isSelected ? AppConstants.rememberCheck : AppConstants.rememberMe
        if let image = UIImage(named: imageName) {
            rememberBtn.setImage(image, for: .normal)
        } else {
            print("Error: Unable to load image named \(imageName)")
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .authentication, controller: AccountTypeVC.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}


// MARK: - Networking
extension LoginVC: AlertProtocol {
    private func authenticateUser() {
        CustomLoader.shared.show()
        self.viewModel.login { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                    let nextVC = ScreenManager.getController(storyboard: .home, controller: RoundedTabbarController.self)
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}


//MARK: - UITextFieldDelegate Methods
extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emialTf {
            emailBgView.backgroundColor = UIColor.white
            emailBgView.layer.borderWidth = 1.5
            emailImg.image = UIImage(named: "ic_email")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
        } else if textField == passTf {
            passBgView.backgroundColor = UIColor.white
            passBgView.layer.borderWidth = 1.5
            passImg.image = UIImage(named: "ic_ActiveLock")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailBgView.backgroundColor = UIColor.textFeildBg
        passBgView.layer.borderWidth = 0
        emailBgView.layer.borderWidth = 0
        emailImg.image = UIImage(named: "ic_emailGray")
        passBgView.backgroundColor = UIColor.textFeildBg
        passImg.image = UIImage(named: "ic_lockIcon")
    }
}
