//
//  ProfileVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 26/02/24.
//

import UIKit

class ProfileVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = AddRecommendedOutfitsRequestModel()
    var outfitRequestModel = GetAllOutfitsRequestModel()
    var responseModel: ProfileResonseModel?
    var outfitsResponseModel: GelAllOutfitsResponseModel?
    var requestModelHighLight = RackRequestModel()
    var outfitId = String()
    
    
    // MARK: - INTERNAL FUNCTIONS
    func getProfileApi(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getProfile{ (result) in
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
    
    func createHighLight(completion: @escaping ApiResponseCompletion) {
        var params = [String: Any]()
        params = self.requestModelHighLight.json
        debugPrint(params)
        if let validationMsg = requestModelHighLight.validationMessage {
            completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
            return
        }
        
        ///Calling api service method
        self.apiServices.createHighLight(params){ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                //                self.responseModel = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func getAllUsersOutfitsApi(completion: @escaping ApiResponseCompletion) {
        var params = [String: Any]()
        params = self.outfitRequestModel.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.getAllUserOutfits(params){ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                self.outfitsResponseModel = JSONDecoder().convertDataToModel(data)
                print("total",self.outfitsResponseModel?.data.total)
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func getOwnOutfitsApi(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getOwnOutfits{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                self.outfitsResponseModel = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    func deleteMyOutfit(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.deleteOwnOutfits(outfitId){ (result) in
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
