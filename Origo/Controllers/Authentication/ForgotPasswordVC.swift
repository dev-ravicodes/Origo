//
//  ForgotPasswordVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var emialTf: UITextField!

    
    //MARK: - Variables
    var viewModel = ForgotPassVM()
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configData()
    }
    
    
    //MARK: - Helpers
    private func configData() {
        
    }
    
    private func prepareRequestModel() {
        self.viewModel.requestModel.email = self.emialTf.text ?? ""
        self.forgotPassApi()
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        prepareRequestModel()
    }
    
}


// MARK: - Networking
extension ForgotPasswordVC: AlertProtocol {
    private func forgotPassApi() {
        CustomLoader.shared.show()
        self.viewModel.forgotPasswordApi { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                let nextVC = ScreenManager.getController(storyboard: .authentication, controller: OtpVC.self)
                nextVC.email = self?.emialTf.text ?? ""
                self?.navigationController?.pushViewController(nextVC, animated: true)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}
