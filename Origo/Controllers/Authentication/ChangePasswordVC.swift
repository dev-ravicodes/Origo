//
//  ChangePasswordVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

class ChangePasswordVC: UIViewController {

    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var passTf: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var conPassTf: UITextField!
    @IBOutlet weak var conPassEyeBtn: UIButton!

    
    //MARK: - Variables
    var viewModel = ForgotPassVM()
    var email = String()
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: - Convenience
    private func toggleSecureTextEntry(for textField: UITextField, eyeButton: UIButton) {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? AppConstants.hidePass : AppConstants.showPass
        if let image = UIImage(named: imageName) {
            eyeButton.setImage(image, for: .normal)
        } else {
            print("Error: Unable to load image named \(imageName)")
        }
    }
    
    private func prepareRequestModel() {
        self.viewModel.requestModelChangePass.email = self.email
        self.viewModel.requestModelChangePass.password = self.passTf.text ?? ""
        self.viewModel.requestModelChangePass.conPass = self.conPassTf.text ?? ""
        self.resetPassApi()
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func passEyeBtnAction(_ sender: UIButton) {
        toggleSecureTextEntry(for: passTf, eyeButton: passEyeBtn)
    }
    
    @IBAction func conPassEyeBtnAction(_ sender: UIButton) {
        toggleSecureTextEntry(for: conPassTf, eyeButton: conPassEyeBtn)
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        prepareRequestModel()
    }

}


// MARK: - Networking
extension ChangePasswordVC: AlertProtocol {
    private func resetPassApi() {
        CustomLoader.shared.show()
        self.viewModel.resetPasswordApi{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                let nextVC = ScreenManager.getController(storyboard: .authentication, controller: CompletedResetPasswordVC.self)
                nextVC.modalPresentationStyle = .overCurrentContext
                nextVC.onLogin = { [weak self] in
                    let nextVC = ScreenManager.getController(storyboard: .authentication, controller: LoginVC.self)
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                }
                self?.navigationController?.present(nextVC, animated: true)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}
