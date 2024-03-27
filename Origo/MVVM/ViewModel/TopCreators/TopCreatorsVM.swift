//
//  TopCreatorsVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 08/02/24.
//

import Foundation

class TopCreatorsVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var responseModel: TopCreatorsResponseModel?
    var fitsRecommendationsResponseModel: OutFitsRecommendationResponseModel?
    var allRacksResponseModel: GetAllRacksOutfitsModel?
    
    
    // MARK: - INTERNAL FUNCTIONS
    func getTopCreators(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getTopCreators { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                self.responseModel = JSONDecoder().convertDataToModel(data)
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func getRecommendedOutfits(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getRecommendedOufits { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                self.fitsRecommendationsResponseModel = JSONDecoder().convertDataToModel(data)
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func getRacksApi(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getRackOutfit{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                self.allRacksResponseModel = JSONDecoder().convertDataToModel(data)
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
        
}
