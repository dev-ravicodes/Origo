//
//  RackVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/03/24.
//

import UIKit

enum Rack {
    case Rename, hide, removeOutfit, remove
}

class RackVM: NSObject {
    //MARK:- VARIABLES
    let apiServices = AuthenticationApiServices()
    var requestModel = RackRequestModel()
    var updateRequestModel = UpdateRackRequestModel()
    var updateRemoveRackRequestModel = UpdateRackRemoveRequestModel()
    var updateRemoveRackOutfitsRequestModel = UpdateRackRemoveOutfitsRequestModel()
    var updateRenameRackOutfitsRequestModel = UpdateRackRenameRequestModel()
    var responseModel: GetOutfitsDetialsModel?
    var rackResponseModel: OneRackDetailsResponseModel?
    var outfitId = String()
    var rack: Rack = .Rename
    var rackId = String()
    
    
    // MARK: - INTERNAL FUNCTIONS
    func createRack(completion: @escaping ApiResponseCompletion) {
        var params = [String: Any]()
            params = self.requestModel.json
            debugPrint(params)
            if let validationMsg = requestModel.validationMessage {
                completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
                return
            }

        ///Calling api service method
        self.apiServices.createNewRack(params){ (result) in
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
    
    func updateRack(completion: @escaping ApiResponseCompletion) {
        var params = [String: Any]()
        if rack  == .hide {
            params = self.updateRequestModel.json
            debugPrint(params)
        } else if rack == .remove {
            params = self.updateRemoveRackRequestModel.json
        }
        else if rack == .removeOutfit {
            params = self.updateRemoveRackOutfitsRequestModel.json
        } else if rack == .Rename{
            params = self.updateRenameRackOutfitsRequestModel.json
        }
        debugPrint(params)
        ///Calling api service method
        self.apiServices.updateRack(params){ (result) in
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
    
    func getRackDetails(completion: @escaping ApiResponseCompletion) {
        ///Calling api service method
        self.apiServices.getRackOutfitDetails(rackId){ (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                
                ///Converting api Data response to respective response model.
                
                self.rackResponseModel = JSONDecoder().convertDataToModel(data)
                
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
}
