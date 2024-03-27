//
//  SignUpVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import UIKit

class SignUpVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = SignUpRequestModel()
    var resuestModelBusiness = SignUpBusinessRequestModel()
    var responseModel: SignUpResponseModel?
    var responseModelBusiness: SignUpBusinessResponseModel?
    var accountType: AccountType = .Business
    
    
    // MARK: - INTERNAL FUNCTIONS
    func signUp(completion: @escaping ApiResponseCompletion) {
        if self.accountType == .Individual {
            if let validationMsg = requestModel.validationMessage {
                completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
                return
            }
            let params = self.requestModel.json
            debugPrint(params)
            ///Calling api service method
            self.apiServices.signUp(params) { (result) in
                switch result {
                case .success(let response):
                    guard let data = response.resultData as? Data else {
                        completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                        return
                    }
                    
                    ///Converting api Data response to respective response model.
                    self.responseModel = JSONDecoder().convertDataToModel(data)
                    AppCache.shared.currentUser = self.responseModel?.data
                    
                    completion(.success(response))
                case .failure(let error):
                    ///Handle failure response
                    completion(.failure(error))
                }
            }
        }
        else {
            if let validationMsg = resuestModelBusiness.validationMessage {
                completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
                return
            }
            let params = self.resuestModelBusiness.json
            debugPrint(params)
            ///Calling api service method
            self.apiServices.signUp(params) { (result) in
                switch result {
                case .success(let response):
                    guard let data = response.resultData as? Data else {
                        completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                        return
                    }
                    
                    ///Converting api Data response to respective response model.
                    self.responseModelBusiness = JSONDecoder().convertDataToModel(data)
                    AppCache.shared.currentUser = self.responseModelBusiness?.data
                    
                    completion(.success(response))
                case .failure(let error):
                    ///Handle failure response
                    completion(.failure(error))
                }
            }
        }

    }
    
}
