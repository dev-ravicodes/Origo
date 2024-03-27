//
//  UploadImageVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 28/02/24.
//

import UIKit

class UploadImageVM: NSObject {
    //MARK:- VARIABLES
    var requestModel = UploadImageRequestModel()
    var requestModelArr = UploadImageArrRequestModel()
    var responseModel : UploadImageResponseModel?
    var responseModelArr : UploadImageArrResponseModel?
    let apiServices = AuthenticationApiServices()
    var fileUrl = String()
    var mimeType = String()
    
    
    // MARK: - INTERNAL FUNCTIONS
    func uploadImage(completion: @escaping ApiResponseCompletion) {
        let params = self.requestModel.json
        let multipartModel = self.requestModel.multipartModel
        ///Calling api service method
        self.apiServices.uploadImage(params, multipartModelArray: multipartModel) { (result) in
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
    
    func uploadArrImage(completion: @escaping ApiResponseCompletion) {
        let params = self.requestModelArr.json
        let multipartModel = self.requestModelArr.multipartModel
        ///Calling api service method
        self.apiServices.uploadArrImage(params, arrMultipart: multipartModel) { (result) in
            switch result {
            case .success(let response):
                guard let data = response.resultData as? Data else {
                    completion(.failure(ApiResponseErrorBlock(message: .somethingWentWrong)))
                    return
                }
                ///Converting api Data response to respective response model.
                self.responseModelArr = JSONDecoder().convertDataToModel(data)
                completion(.success(response))
            case .failure(let error):
                ///Handle failure response
                completion(.failure(error))
            }
        }
    }
        
}
