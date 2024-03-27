//
//  LoginVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import UIKit

class LoginVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = LoginRequestModel()
    var responseModel: LoginResponseModel?
    
    
    // MARK: - INTERNAL FUNCTIONS
    func login(completion: @escaping ApiResponseCompletion) {
        if let validationMsg = requestModel.validationMessage {
            completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
            return
        }
        
        let params = self.requestModel.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.login(params) { (result) in
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
    
}
