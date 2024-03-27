//
//  OtpVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 07/02/24.
//

import UIKit

class OtpVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = VerifyPasswordOtpRequestModel()
    var responseModel: LoginResponseModel?
    var resendPassOtpRequestModel = ResendPasswordOtpRequestModel()
    var responseModelResendPassOtp: ResendPassOtpResponseModel?
    
    
    // MARK: - INTERNAL FUNCTIONS
    func verifyForgotPassOtp(completion: @escaping ApiResponseCompletion) {
        if let validationMsg = requestModel.validationMessage {
            completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
            return
        }
        
        let params = self.requestModel.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.verifyPasswordOtp(params) { (result) in
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
    
    func resendForgetPassOtp(completion: @escaping ApiResponseCompletion) {
        let params = self.resendPassOtpRequestModel.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.resendPasswordOtp(params) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                self.responseModelResendPassOtp = JSONDecoder().convertDataToModel(data)
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
}
