//
//  HangItVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/03/24.
//

import UIKit

class HangItVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = HangItRequestModel()
    var responseModel: GetAllRacksResponseModel?
    var hangItResponseModel: HangItResponseModel?
    var responseModelAllRacksWithoutPrimary: AllRacksWithoutPrimary?
    var RequestModelAddToRack = AddToRackRequestModel()
    var outfitId = String()
    
    
    // MARK: - INTERNAL FUNCTIONS
    func hangIt(completion: @escaping ApiResponseCompletion) {
        let params = self.requestModel.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.hangIt(params){ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                self.hangItResponseModel = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func gatAllRacks(completion: @escaping ApiResponseCompletion) {
        
        ///Calling api service method
        self.apiServices.getAllRacks{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                self.responseModel = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func gatAllRacksExceptPrimary(completion: @escaping ApiResponseCompletion) {
        
        ///Calling api service method
        self.apiServices.getAllRacksExceptPrimary{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                self.responseModelAllRacksWithoutPrimary = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func getMyHighlights(completion: @escaping ApiResponseCompletion) {
        
        ///Calling api service method
        self.apiServices.getMyHighlights{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                self.responseModelAllRacksWithoutPrimary = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func likeOutfit(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.likeOutfit(outfitId){ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
}
