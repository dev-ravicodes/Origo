//
//  HighLightsVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 15/03/24.
//

import UIKit

class HighLightsVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = RackRequestModel()
    var updateRemoveHighLightRequestModel = UpdateHighLightRemoveRequestModel()
    var updateRemoveHighLightOutfitsRequestModel = UpdateHighLightsRemoveOutfitsRequestModel()
    var highLightRenameRequestModel = HighLightRenameRequestModel()
    var responseModel: HighlightResponseModel?
    var highLightResponseModel: SingleHighLightResponseModel?
    var outfitId = String()
    var highLight: HighLights = .rename
    var highlightId = String()
    
    
    // MARK: - INTERNAL FUNCTIONS
    func updateHighLightsApi(completion: @escaping ApiResponseCompletion) {
        var params = [String: Any]()
        if highLight == .rename {
            params = self.highLightRenameRequestModel.json
        } else if highLight == .removeoutfits {
            params = updateRemoveHighLightOutfitsRequestModel.json
        } else if highLight == .remove {
            params = updateRemoveHighLightRequestModel.json
        }
        debugPrint(params)
        ///Calling api service method
        self.apiServices.updateHighlights(params){ (result) in
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
    
    func getHighlightDetails(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getHighlightDetails(highlightId){ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                self.highLightResponseModel = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
    
}
