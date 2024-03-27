//
//  AddPostVM.swift
//  Origo
//
//  Created by iTechnolabs on 15/03/24.
//

import Foundation


class AddOutfitVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = AddOutfitDetailModel()
    var categoriesResponseModel: OutfitCategoryResponse?
    var colorResponseModel: OutfitColorResponse?
    var materialResponseModel: OutfitMaterialResponse?
    
    
    // MARK: - INTERNAL FUNCTIONS
   
    func uploadOutfit(completion: @escaping ApiResponseCompletion) {
        var params = [String: Any]()
            params = self.requestModel.json
            debugPrint(params)
//            if let validationMsg = requestModel.validationMessage {
//                completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
//                return
//            }

        ///Calling api service method
        self.apiServices.uploadOutfit(params){ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
//                self.categoriesResponseModel = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func getAllCategories(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getAllCategories { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                self.categoriesResponseModel = JSONDecoder().convertDataToModel(data)
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func getAllColors(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getAllColors{ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                self.colorResponseModel = JSONDecoder().convertDataToModel(data)
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func getAllMaterials(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getAllMaterials { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                self.materialResponseModel = JSONDecoder().convertDataToModel(data)
                ///Converting api Data response to respective response model.
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
}
