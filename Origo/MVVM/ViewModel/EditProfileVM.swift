//
//  EditProfileVM.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 28/02/24.
//

import UIKit

class EditProfileVM: NSObject {
    //Properties
    let apiServices = AuthenticationApiServices()
//    var responseModel: GetProfileResponseModel?
    let objCameraGalleryClass = CameraGalleryClass()
    var popoverController: UIPopoverPresentationController?
    var requestModel = EditProfileRequestModel()
    
    
    //MARK: - INTERNAL FUNCTIONS
    func updateProfile(completion: @escaping ApiResponseCompletion) {
            if let validationMsg = requestModel.validationMessage {
                completion(.failure(ApiResponseErrorBlock(message: validationMsg)))
                return
            }
        
        let params = self.requestModel.json
        debugPrint(params)
        ///Calling api service method
        self.apiServices.editProfile(params) { (result) in
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
}
