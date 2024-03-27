//
//  OutfitsDetailsVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/03/24.
//

import UIKit
class OutfitsDetailsVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var responseModel: GetOutfitsDetialsModel?
    var outfitId = String()
    
    // MARK: - INTERNAL FUNCTIONS
    func getOutfitDetails(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getOutfitsDetails(outfitId){ (result) in
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
    
}
