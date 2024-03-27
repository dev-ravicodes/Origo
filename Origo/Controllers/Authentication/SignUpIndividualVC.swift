//
//  SignUpIndividualVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

class SignUpIndividualVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var fullNameBgView: UIView!
    @IBOutlet weak var userNameBgView: UIView!
    @IBOutlet weak var emailBgView: UIView!
    @IBOutlet weak var dobBgView: UIView!
    @IBOutlet weak var addressBgView: UIView!
    @IBOutlet weak var passBgView: UIView!
    @IBOutlet weak var conPassBgView: UIView!
    @IBOutlet weak var fullNameImg: UIImageView!
    @IBOutlet weak var userNameImg: UIImageView!
    @IBOutlet weak var emailImg: UIImageView!
    @IBOutlet weak var calendarImg: UIImageView!
    @IBOutlet weak var addressImg: UIImageView!
    @IBOutlet weak var passImg: UIImageView!
    @IBOutlet weak var conPassImg: UIImageView!
    @IBOutlet weak var fullNameTf: UITextField!
    @IBOutlet weak var userNameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var dobTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var passTf: UITextField!
    @IBOutlet weak var conPass: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var conPassEyeBtn: UIButton!
    @IBOutlet weak var termsAndConditionLbl: UILabel!
    @IBOutlet weak var termsAndConditionBtn: UIButton!

    
    //MARK: - Variables
    var viewModel = SignUpVM()
    var datePickerView = UIDatePicker()
    var accountType = String()
    let text = "I agree with the Terms and Conditions and the Privacy policy."

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configData()
    }
    
    
    //MARK: - Convenience
    private func configData() {
        configDatePicker()
        termsAndConditionLbl.text = text
        self.termsAndConditionLbl.textColor =  UIColor.gray
        let underlineAttriString = NSMutableAttributedString(string: text)
        let termsRange = (text as NSString).range(of: "Terms and Conditions")
        let privacyRange = (text as NSString).range(of: "Privacy policy")
        underlineAttriString.addAttributes([NSAttributedString.Key.font: UIFont.urbanistSemiBold(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.buttonBG], range: termsRange)
        underlineAttriString.addAttributes([NSAttributedString.Key.font: UIFont.urbanistSemiBold(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.buttonBG], range: privacyRange)
        termsAndConditionLbl.attributedText = underlineAttriString
        termsAndConditionLbl.isUserInteractionEnabled = true
        termsAndConditionLbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    private func configDatePicker() {
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        datePickerView.semanticContentAttribute = .forceRightToLeft
        datePickerView.subviews.first?.semanticContentAttribute = .forceRightToLeft
        dobTf.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        dobTf.inputView = datePickerView
        datePickerView.maximumDate = Date().addingTimeInterval(-86400)
        datePickerView.frame.size = CGSize(width: 0, height: 200)
    }
    
    private func prepareRequestModel() {
        self.viewModel.requestModel.fullName = self.fullNameTf.text ?? ""
        self.viewModel.requestModel.userName = self.userNameTf.text ?? ""
        self.viewModel.requestModel.email = self.emailTf.text ?? ""
        self.viewModel.requestModel.dob = self.dobTf.text ?? ""
        self.viewModel.requestModel.accountType = self.accountType
        self.viewModel.requestModel.address = SignUpAddress()
        self.viewModel.requestModel.address?.coordinates = [12.2,12.2]
        self.viewModel.requestModel.address?.city = self.addressTf.text ?? ""
        self.viewModel.requestModel.address?.state = self.addressTf.text ?? ""
        self.viewModel.requestModel.address?.country = self.addressTf.text ?? ""
        self.viewModel.requestModel.password = self.passTf.text ?? ""
        self.viewModel.requestModel.conPass = self.conPass.text ?? ""
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
    
    private func configUI(_ textField: UITextField) {
        if textField == fullNameTf {
            fullNameBgView.backgroundColor = UIColor.white
            fullNameBgView.layer.borderWidth = 1.5
            fullNameImg.image = UIImage(named: "ic_fullName")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_userName")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            dobBgView.backgroundColor = UIColor.textFeildBg
            calendarImg.image = UIImage(named: "ic_calenderd")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == userNameTf {
            fullNameBgView.backgroundColor = UIColor.textFeildBg
            fullNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.white
            userNameBgView.layer.borderWidth = 1.5
            userNameImg.image = UIImage(named: "ic_userNameActive")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            dobBgView.backgroundColor = UIColor.textFeildBg
            calendarImg.image = UIImage(named: "ic_calenderd")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == emailTf {
            fullNameBgView.backgroundColor = UIColor.textFeildBg
            fullNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_userName")
            emailBgView.backgroundColor = UIColor.white
            emailBgView.layer.borderWidth = 1.5
            emailImg.image = UIImage(named: "ic_email")
            dobBgView.backgroundColor = UIColor.textFeildBg
            calendarImg.image = UIImage(named: "ic_calenderd")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == dobTf {
            fullNameBgView.backgroundColor = UIColor.textFeildBg
            fullNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_userName")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            dobBgView.backgroundColor = UIColor.white
            dobBgView.layer.borderWidth = 1.5
            calendarImg.image = UIImage(named: "ic_calenderActive")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == addressTf {
            fullNameBgView.backgroundColor = UIColor.textFeildBg
            fullNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_userName")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            dobBgView.backgroundColor = UIColor.textFeildBg
            calendarImg.image = UIImage(named: "ic_calenderd")
            addressBgView.backgroundColor = UIColor.white
            addressBgView.layer.borderWidth = 1.5
            addressImg.image = UIImage(named: "ic_addressActive")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == passTf {
            fullNameBgView.backgroundColor = UIColor.textFeildBg
            fullNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_userName")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            dobBgView.backgroundColor = UIColor.textFeildBg
            calendarImg.image = UIImage(named: "ic_calenderd")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.white
            passBgView.layer.borderWidth = 1.5
            passImg.image = UIImage(named: "ic_ActiveLock")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == conPass {
            fullNameBgView.backgroundColor = UIColor.textFeildBg
            fullNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_userName")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            dobBgView.backgroundColor = UIColor.textFeildBg
            calendarImg.image = UIImage(named: "ic_calenderd")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.white
            conPassBgView.layer.borderWidth = 1.5
            conPassImg.image = UIImage(named: "ic_ActiveLock")
        }
    }
    
    private func changeDesigns() {
        fullNameBgView.layer.borderWidth = 0
        userNameBgView.layer.borderWidth = 0
        emailBgView.layer.borderWidth = 0
        dobBgView.layer.borderWidth = 0
        addressBgView.layer.borderWidth = 0
        passBgView.layer.borderWidth = 0
        conPassBgView.layer.borderWidth = 0
        fullNameBgView.backgroundColor = UIColor.textFeildBg
        fullNameImg.image = UIImage(named: "ic_userIconGray")
        userNameBgView.backgroundColor = UIColor.textFeildBg
        userNameImg.image = UIImage(named: "ic_userName")
        emailBgView.backgroundColor = UIColor.textFeildBg
        emailImg.image = UIImage(named: "ic_emailGray")
        dobBgView.backgroundColor = UIColor.textFeildBg
        calendarImg.image = UIImage(named: "ic_calenderd")
        addressBgView.backgroundColor = UIColor.textFeildBg
        addressImg.image = UIImage(named: "ic_address")
        conPassBgView.backgroundColor = UIColor.textFeildBg
        conPassImg.image = UIImage(named: "ic_lockIcon")
        passBgView.backgroundColor = UIColor.textFeildBg
        passImg.image = UIImage(named: "ic_lockIcon")
    }
    
    
    //MARK: - Objc Methods
    @objc func doneButtonPressed() {
        if let datePicker = self.dobTf.inputView as? UIDatePicker {
            let selectedDate = datePicker.date
            let currentDate = Date()
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: selectedDate, to: currentDate)
            if let userAge = ageComponents.year, userAge < 13 {
                showAlertWithText("Sorry, you must be at least 13 years old to sign up.")
                return
            }
            self.dobTf.text = selectedDate.getFormattedDate(format: .ymd)
        }
        self.dobTf.resignFirstResponder()

    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (text as NSString).range(of: "Terms and Conditions")
        let privacyRange = (text as NSString).range(of: "Privacy policy")
        if gesture.didTapAttributedTextInLabel(label: termsAndConditionLbl, inRange: termsRange) {
            print("Tapped terms")
        } else if gesture.didTapAttributedTextInLabel(label: termsAndConditionLbl, inRange: privacyRange) {
            print("Tapped privacy")
        }
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        prepareRequestModel()
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .authentication, controller: AccountTypeVC.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func passEyeBtnAction(_ sender: UIButton) {
        toggleSecureTextEntry(for: passTf, eyeButton: passEyeBtn)
    }
    
    @IBAction func conPassEyeBtnAction(_ sender: UIButton) {
        toggleSecureTextEntry(for: conPass, eyeButton: conPassEyeBtn)
    }
    
    @IBAction func agreeTermsActions(_ sender: UIButton) {
        termsAndConditionBtn.isSelected.toggle()
        let imageName = termsAndConditionBtn.isSelected ? AppConstants.rememberCheck : AppConstants.rememberMe
        if let image = UIImage(named: imageName) {
            viewModel.requestModel.image = image
            termsAndConditionBtn.setImage(image, for: .normal)
        } else {
            print("Error: Unable to load image named \(imageName)")
        }
    }
    
}

// MARK: - Networking
extension SignUpIndividualVC: AlertProtocol {
    private func authenticateUser() {
        CustomLoader.shared.show()
        self.viewModel.signUp { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                let nextVC = ScreenManager.getController(storyboard: .authentication, controller: CompletedSignUpPopUp.self)
                nextVC.modalPresentationStyle = .overCurrentContext
                nextVC.onContinue = { [weak self] in
                    if !AppCache.shared.newUser {
                        let nextVC = ScreenManager.getController(storyboard: .onboarding, controller: OnBoardingVC.self)
                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    } else {
                        AppCache.shared.newUser = false
                        let nextVC = ScreenManager.getController(storyboard: .onboarding, controller: FitsTasteVC.self)
                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    }
                }
                self?.navigationController?.present(nextVC, animated: true)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}


//MARK: - UITextFieldDelegate Methods
extension SignUpIndividualVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.configUI(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.changeDesigns()
    }
}
