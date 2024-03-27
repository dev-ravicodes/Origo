//
//  SingUpBussinessVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

class SingUpBussinessVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var businessBgView: UIView!
    @IBOutlet weak var userNameBgView: UIView!
    @IBOutlet weak var emailBgView: UIView!
    @IBOutlet weak var webLinkBgView: UIView!
    @IBOutlet weak var addressBgView: UIView!
    @IBOutlet weak var passBgView: UIView!
    @IBOutlet weak var conPassBgView: UIView!
    @IBOutlet weak var buisnesNameImg: UIImageView!
    @IBOutlet weak var userNameImg: UIImageView!
    @IBOutlet weak var emailImg: UIImageView!
    @IBOutlet weak var webLinkImg: UIImageView!
    @IBOutlet weak var addressImg: UIImageView!
    @IBOutlet weak var passImg: UIImageView!
    @IBOutlet weak var conPassImg: UIImageView!
    @IBOutlet weak var businessNameTf: UITextField!
    @IBOutlet weak var userNameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var linkToWebTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var passTf: UITextField!
    @IBOutlet weak var conPass: UITextField!
    @IBOutlet weak var passEyeBtn: UIButton!
    @IBOutlet weak var conPassEyeBtn: UIButton!
    @IBOutlet weak var termsAndConditionLbl: UILabel!
    @IBOutlet weak var termsAndConditionBtn: UIButton!
    
    
    //MARK: - Variables
    var viewModel = SignUpVM()
    var accountType = String()
    let text = "I agree with the Terms and Conditions and the Privacy policy."
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configData()
    }
    
    
    //MARK: - Convenience
    private func configData() {
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
    
    private func prepareRequestModel() {
        self.viewModel.resuestModelBusiness.businessName = self.businessNameTf.text ?? ""
        self.viewModel.resuestModelBusiness.userName = self.userNameTf.text ?? ""
        self.viewModel.resuestModelBusiness.email = self.emailTf.text ?? ""
        if self.linkToWebTf.text != "" {
            self.viewModel.resuestModelBusiness.webLink = self.linkToWebTf.text ?? ""
        }
        else {
            self.viewModel.resuestModelBusiness.webLink = nil
        }
        self.viewModel.resuestModelBusiness.accountType = self.accountType
        self.viewModel.resuestModelBusiness.address = SignUpAddress()
        self.viewModel.resuestModelBusiness.address?.city = self.addressTf.text ?? ""
        self.viewModel.resuestModelBusiness.address?.state = self.addressTf.text ?? ""
        self.viewModel.resuestModelBusiness.address?.country = self.addressTf.text ?? ""
        self.viewModel.resuestModelBusiness.address?.coordinates = [12.2,12.2]
        self.viewModel.resuestModelBusiness.password = self.passTf.text ?? ""
        self.viewModel.resuestModelBusiness.conPass = self.conPass.text ?? ""
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
        if textField == businessNameTf {
            businessBgView.backgroundColor = UIColor.white
            businessBgView.layer.borderWidth = 1.5
            buisnesNameImg.image = UIImage(named: "ic_fullName")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_linkUser")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            webLinkBgView.backgroundColor = UIColor.textFeildBg
            webLinkImg.image = UIImage(named: "ic_linkingWeb")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == userNameTf {
            businessBgView.backgroundColor = UIColor.textFeildBg
            buisnesNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.white
            userNameBgView.layer.borderWidth = 1.5
            userNameImg.image = UIImage(named: "ic_userNameActiveBusiness")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            webLinkBgView.backgroundColor = UIColor.textFeildBg
            webLinkImg.image = UIImage(named: "ic_linkingWeb")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == emailTf {
            businessBgView.backgroundColor = UIColor.textFeildBg
            buisnesNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_linkUser")
            emailBgView.backgroundColor = UIColor.white
            emailBgView.layer.borderWidth = 1.5
            emailImg.image = UIImage(named: "ic_email")
            webLinkBgView.backgroundColor = UIColor.textFeildBg
            webLinkImg.image = UIImage(named: "ic_linkingWeb")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == linkToWebTf {
            businessBgView.backgroundColor = UIColor.textFeildBg
            buisnesNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_linkUser")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            webLinkBgView.backgroundColor = UIColor.white
            webLinkBgView.layer.borderWidth = 1.5
            webLinkImg.image = UIImage(named: "ic_linkActive")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == addressTf {
            businessBgView.backgroundColor = UIColor.textFeildBg
            buisnesNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_linkUser")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            webLinkBgView.backgroundColor = UIColor.textFeildBg
            webLinkImg.image = UIImage(named: "ic_linkingWeb")
            addressBgView.backgroundColor = UIColor.white
            addressBgView.layer.borderWidth = 1.5
            addressImg.image = UIImage(named: "ic_addressActive")
            passBgView.backgroundColor = UIColor.textFeildBg
            passImg.image = UIImage(named: "ic_lockIcon")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == passTf {
            businessBgView.backgroundColor = UIColor.textFeildBg
            buisnesNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_linkUser")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            webLinkBgView.backgroundColor = UIColor.textFeildBg
            webLinkImg.image = UIImage(named: "ic_linkingWeb")
            addressBgView.backgroundColor = UIColor.textFeildBg
            addressImg.image = UIImage(named: "ic_address")
            passBgView.backgroundColor = UIColor.white
            passBgView.layer.borderWidth = 1.5
            passImg.image = UIImage(named: "ic_ActiveLock")
            conPassBgView.backgroundColor = UIColor.textFeildBg
            conPassImg.image = UIImage(named: "ic_lockIcon")
        }
        else if textField == conPass {
            businessBgView.backgroundColor = UIColor.textFeildBg
            buisnesNameImg.image = UIImage(named: "ic_userIconGray")
            userNameBgView.backgroundColor = UIColor.textFeildBg
            userNameImg.image = UIImage(named: "ic_linkUser")
            emailBgView.backgroundColor = UIColor.textFeildBg
            emailImg.image = UIImage(named: "ic_emailGray")
            webLinkBgView.backgroundColor = UIColor.textFeildBg
            webLinkImg.image = UIImage(named: "ic_linkingWeb")
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
        businessBgView.layer.borderWidth = 0
        userNameBgView.layer.borderWidth = 0
        emailBgView.layer.borderWidth = 0
        webLinkBgView.layer.borderWidth = 0
        addressBgView.layer.borderWidth = 0
        passBgView.layer.borderWidth = 0
        conPassBgView.layer.borderWidth = 0
        businessBgView.backgroundColor = UIColor.textFeildBg
        buisnesNameImg.image = UIImage(named: "ic_userIconGray")
        userNameBgView.backgroundColor = UIColor.textFeildBg
        userNameImg.image = UIImage(named: "ic_linkUser")
        emailBgView.backgroundColor = UIColor.textFeildBg
        emailImg.image = UIImage(named: "ic_emailGray")
        webLinkBgView.backgroundColor = UIColor.textFeildBg
        webLinkImg.image = UIImage(named: "ic_linkingWeb")
        addressBgView.backgroundColor = UIColor.textFeildBg
        addressImg.image = UIImage(named: "ic_address")
        conPassBgView.backgroundColor = UIColor.textFeildBg
        conPassImg.image = UIImage(named: "ic_lockIcon")
        passBgView.backgroundColor = UIColor.textFeildBg
        passImg.image = UIImage(named: "ic_lockIcon")
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func addressBtnAction(_ sender: Any) {
        //        showLocationSearch()
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
            viewModel.resuestModelBusiness.image = image
            termsAndConditionBtn.setImage(image, for: .normal)
        } else {
            print("Error: Unable to load image named \(imageName)")
        }
    }
    
    
    // MARK: - Objc Methods
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (text as NSString).range(of: "Terms and Conditions")
        let privacyRange = (text as NSString).range(of: "Privacy policy")
        if gesture.didTapAttributedTextInLabel(label: termsAndConditionLbl, inRange: termsRange) {
            print("Tapped terms")
        } else if gesture.didTapAttributedTextInLabel(label: termsAndConditionLbl, inRange: privacyRange) {
            print("Tapped privacy")
        }
    }
    
}


// MARK: - Networking
extension SingUpBussinessVC: AlertProtocol {
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
extension SingUpBussinessVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.configUI(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.changeDesigns()
    }
}


//MARK: - GMSAutocompleteViewControllerDelegate
//extension SingUpBussinessVC: GMSAutocompleteViewControllerDelegate {
//
//    private func showLocationSearch() {
//        let acController = GMSAutocompleteViewController()
//        acController.delegate = self
//        self.present(acController, animated: true, completion: nil)
//    }
//
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        let selectedLocation = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
//        GeoCoder.fetchCityAndCountry(from: selectedLocation) { [weak self] (name, thoroughfare, subThorough, locality, subLocality, admin, subAdmin, country, postalCode, error) in
//            guard error == nil else {
//                debugPrint("Error fetching address lines")
//                return
//            }
//            self?.addressTf.text = "\(locality ?? "") \(subLocality ?? "") \(admin ?? "") \(country ?? "")"
//        }
//        self.dismiss(animated: true)
//    }
//
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        Logger.printLog(.error, "Fail to autocomplete location Error: \(error.localizedDescription)")
//    }
//
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//}

extension UIView{
    func enabledField(imgViw:UIImageView, imageName: String) {
        self.backgroundColor = .white
        imgViw.image = UIImage(named: imageName)
    }
    
    func disabledField(imgViw:UIImageView, imageName: String) {
        self.backgroundColor = .textFeildBg
        imgViw.image = UIImage(named: imageName)
    }
}
