//
//  ForgotPassVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import UIKit

class ForgotPassVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = ForgotPassRequestModel()
    var requestModelChangePass = ChangePasswordRequestModel()
    
    
    // MARK: - INTERNAL FUNCTIONS
    func forgotPasswordApi(completion: @escaping ApiResponseCompletion) {
        if let validationMsg = requestModel.validationMessage {
            completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
            return
        }
        
        let params = self.requestModel.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.forgotPassword(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func resetPasswordApi(completion: @escaping ApiResponseCompletion) {
        if let validationMsg = requestModelChangePass.validationMessage {
            completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
            return
        }
        
        let params = self.requestModelChangePass.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.resetPassword(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
}
