//
//  SelectRecommendationOutfitsVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 26/02/24.
//

import UIKit

class SelectRecommendationOutfitsVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = AddRecommendedOutfitsRequestModel()
    
    
    // MARK: - INTERNAL FUNCTIONS
    func addRecommendedOutfits(completion: @escaping ApiResponseCompletion) {
        let params = self.requestModel.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.addRecommendationOutfits(params) { (result) in
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
