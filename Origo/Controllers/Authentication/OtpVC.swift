//
//  OtpVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

class OtpVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var firstOtpTf: UITextField!
    @IBOutlet weak var secondOtpTf: UITextField!
    @IBOutlet weak var thirdOtpTf: UITextField!
    @IBOutlet weak var fourthOtpTf: UITextField!

    
    //MARK: - Variables
    var viewModel = OtpVM()
    var email = String()

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    
    //MARK: - Convenience
    private func configUI() {
        
    }
    
    private func prepareRequestModel() {
        self.viewModel.requestModel.email = self.email
        self.viewModel.requestModel.otp = (self.firstOtpTf.text ?? "") + (self.secondOtpTf.text ?? "") + (self.thirdOtpTf.text ?? "") + (self.fourthOtpTf.text ?? "")
        self.verifyPassApi()
    }
    
    private func prepareResendPassOtpRequestModel() {
        self.viewModel.resendPassOtpRequestModel.email = self.email
        self.resendPassOtpApi()
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func resendAction(_ sender: UIButton) {
        prepareResendPassOtpRequestModel()
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        prepareRequestModel()
    }

}


//MARK: - UITextFieldDelegate Methods
extension OtpVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count <= maxLength {
            textField.text = updatedText
            if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                nextTextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            return true
        } else {
            return false
        }
    }
}


// MARK: - Networking
extension OtpVC: AlertProtocol {
    private func verifyPassApi() {
        CustomLoader.shared.show()
        self.viewModel.verifyForgotPassOtp { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                let nextVC = ScreenManager.getController(storyboard: .authentication, controller: ChangePasswordVC.self)
                nextVC.email = self?.email ?? ""
                self?.navigationController?.pushViewController(nextVC, animated: true)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func resendPassOtpApi() {
        CustomLoader.shared.show()
        self.viewModel.resendForgetPassOtp { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(let reseponse):
                self?.showAlert(message: reseponse.message)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}
