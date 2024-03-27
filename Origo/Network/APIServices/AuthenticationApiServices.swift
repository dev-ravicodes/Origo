//
//  AuthenticationApiServices.swift
//

import Foundation

fileprivate enum AuthenticationApiServicesEndPoints: APIService {
    //Define cases according to API's
    case login(_ parameters: [String: Any])
    case signUp(_ parameters: [String: Any])
    case forgotPassword(_ parameters: [String: Any])
    case resetPassword(_ parameters: [String: Any])
    case verifyPasswordOtp(_ parameters: [String: Any])
    case uploadImage(_ parameters:[String:String])
    case uploadArrImage(_ parameters:[String:String])
    case topCreators
    case getOutFits
    case getCategories
    case getColors
    case getMaterials
    case resendPasswordOtp(_ parameters:[String:Any])
    case addRecommendationOutfits(_ parameters:[String:Any])
    case getProfile
    case editProfile(_ parameters:[String:Any])
    case getAllUserOutfits(_ parameters:[String:Any])
    case hangIt(_ parameters:[String:Any])
    case allRacks
    case rackOutfit
    case getOutfitDetails(String)
    case createNewRack(_ parameters:[String:Any])
    case uploadOutfit(_ parameters:[String:Any])
    case updateRack(_ parameters:[String:Any])
    case getRackOutfit(String)
    case getHighLightsDetails(String)
    case createHighlight(_ parameters:[String:Any])
    case allRacksExceptPrimary
    case updateHighlights(_ parameters:[String:Any])
    case getOwnOutfits
    case deleteOwnOutfit(String)
    case getMyHighlights
    case likeOutfit(String)
    
    //Return path according to api case
    var path: String {
        switch self {
        case .login:
            return AppConstants.Urls.apiBaseUrl + "users/sign-in"
        case .signUp:
            return AppConstants.Urls.apiBaseUrl + "users"
        case .forgotPassword:
            return AppConstants.Urls.apiBaseUrl + "users/forgot-password"
        case .resetPassword:
            return AppConstants.Urls.apiBaseUrl + "users/reset-password"
        case .verifyPasswordOtp:
            return AppConstants.Urls.apiBaseUrl + "users/verify-otp"
        case .uploadImage:
            return AppConstants.Urls.apiBaseUrl + "users/upload-file"
        case .uploadArrImage:
            return AppConstants.Urls.apiBaseUrl + "users/uploads"
        case .getProfile, .editProfile:
            return AppConstants.Urls.apiBaseUrl + "users"
        case .topCreators:
            return AppConstants.Urls.apiBaseUrl + "creators/top-creators"
        case .getOutFits:
            return AppConstants.Urls.apiBaseUrl + "outfits/get-recommendations"
        case .getCategories:
            return AppConstants.Urls.apiBaseUrl + "outfits/category"
        case .getColors:
            return AppConstants.Urls.apiBaseUrl + "outfits/color"
        case .getMaterials:
            return AppConstants.Urls.apiBaseUrl + "outfits/material"
        case .resendPasswordOtp:
            return AppConstants.Urls.apiBaseUrl + "users/resend-otp"
        case .addRecommendationOutfits:
            return AppConstants.Urls.apiBaseUrl + "outfits/add-recommendations"
        case .getAllUserOutfits(let params):
            return AppConstants.Urls.apiBaseUrl + "outfits/?" + params.queryString
        case .hangIt:
            return AppConstants.Urls.apiBaseUrl + "rack/hang-it"
        case .allRacks:
            return AppConstants.Urls.apiBaseUrl + "rack/all"
        case .rackOutfit:
            return AppConstants.Urls.apiBaseUrl + "rack/outfits"
        case .getOutfitDetails(let outfitId):
            return AppConstants.Urls.apiBaseUrl + "outfits/\(outfitId)"
        case .createNewRack:
            return AppConstants.Urls.apiBaseUrl + "rack" 
        case .uploadOutfit:
            return AppConstants.Urls.apiBaseUrl + "outfits"
        case .updateRack:
            return AppConstants.Urls.apiBaseUrl + "rack/update"
        case .getRackOutfit(let rackId):
            return AppConstants.Urls.apiBaseUrl + "rack/\(rackId)"
        case .createHighlight:
            return AppConstants.Urls.apiBaseUrl + "hightlights/"
        case .allRacksExceptPrimary:
            return AppConstants.Urls.apiBaseUrl + "rack/"
        case .updateHighlights:
            return AppConstants.Urls.apiBaseUrl + "hightlights/update"
        case .getHighLightsDetails(let highlightId):
            return AppConstants.Urls.apiBaseUrl + "hightlights/\(highlightId)"
        case .getOwnOutfits:
            return AppConstants.Urls.apiBaseUrl + "outfits/get-own?"
        case .deleteOwnOutfit(let outfitId):
            return AppConstants.Urls.apiBaseUrl + "outfits/\(outfitId)"
        case .getMyHighlights:
            return AppConstants.Urls.apiBaseUrl + "hightlights/own"
        case .likeOutfit(let outfitId):
            return AppConstants.Urls.apiBaseUrl + "outfits/like/\(outfitId)"
        }
    }
    
    //Return resource according to api case
    var resource: Resource {
        let headers: [String: Any] = [
            "Content-Type": "application/json",
            "Accept" : "application/json",
            "fcm-token":"fcm_token", //change later
            "device-id":"1"
        ]
        let headersWithToken: [String: Any] = [
            "Content-Type": "application/json",
            "Authorization": AppCache.shared.currentUser?.token ?? "",
            "Accept" : "application/json",
            "device-id":"1"
        ]
        
        switch self {
        case .login(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .signUp(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .forgotPassword(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .verifyPasswordOtp(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .resetPassword(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .getProfile, .topCreators, .getOutFits,.getCategories , .getColors , .getMaterials, .getAllUserOutfits, .allRacks, .rackOutfit, .getOutfitDetails, .getRackOutfit, .allRacksExceptPrimary, .getHighLightsDetails, .getOwnOutfits, .getMyHighlights:
            return Resource(method: .get, parameters: nil, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .uploadImage:
            return Resource(method: .post, parameters: nil, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .uploadArrImage:
            return Resource(method: .post, parameters: nil, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .resendPasswordOtp(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headers, validator: APIDataResultValidator(), responseType: .data)
        case .addRecommendationOutfits(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .editProfile(let params):
            return Resource(method: .put, parameters: params, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .hangIt(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .createNewRack(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data) 
        case .uploadOutfit(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .updateRack(let params):
            return Resource(method: .put, parameters: params, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .createHighlight(let params):
            return Resource(method: .post, parameters: params, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .updateHighlights(let params):
            return Resource(method: .put, parameters: params, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .deleteOwnOutfit:
            return Resource(method: .delete, parameters: nil, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        case .likeOutfit:
            return Resource(method: .post, parameters: nil, arrParameters: [], encoding: .QUERY, headers: headersWithToken, validator: APIDataResultValidator(), responseType: .data)
        }
    }
}

struct AuthenticationApiServices {
    
    func login(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.login(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func signUp(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.signUp(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func forgotPassword(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.forgotPassword(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func verifyPasswordOtp(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.verifyPasswordOtp(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func resetPassword(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.resetPassword(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func getProfile(_ completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getProfile.urlRequest(completionBlock: completionBlock)
    }
    
    func uploadImage(_ parameters: [String: String], multipartModelArray: MultipartModel, completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.uploadImage(parameters).requestMultipart(modelArray: multipartModelArray, uploadType: .data, completionBlock: completionBlock)
    }
    
    func uploadArrImage(_ parameters: [String: String], multipartModelArray: MultipartModel?=nil, arrMultipart:[MultipartModel], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.uploadArrImage(parameters).requestMultipart(modelArray: multipartModelArray,arrMultipart: arrMultipart, uploadType: .data, completionBlock: completionBlock)
    }
    
    func getTopCreators(completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.topCreators.urlRequest(completionBlock: completionBlock)
    }
    
    func getRecommendedOufits(completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getOutFits.urlRequest(completionBlock: completionBlock)
    }
    
    func getAllCategories(completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getCategories.urlRequest(completionBlock: completionBlock)
    }
    
    func getAllColors(completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getColors.urlRequest(completionBlock: completionBlock)
    }
    
    func getAllMaterials(completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getMaterials.urlRequest(completionBlock: completionBlock)
    }
    
    func resendPasswordOtp(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.resendPasswordOtp(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func addRecommendationOutfits(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.addRecommendationOutfits(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func editProfile(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.editProfile(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func getAllUserOutfits(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getAllUserOutfits(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func hangIt(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.hangIt(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func getAllRacks(_ completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.allRacks.urlRequest(completionBlock: completionBlock)
    }
    
    func getRackOutfit(completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.rackOutfit.urlRequest(completionBlock: completionBlock)
    }
    
    func getOutfitsDetails(_ outFitId: String,  completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getOutfitDetails(outFitId).urlRequest(completionBlock: completionBlock)
    }
    
    func createNewRack(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.createNewRack(parameters).urlRequest(completionBlock: completionBlock)
    }
    func uploadOutfit(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.uploadOutfit(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func updateRack(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.updateRack(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func getRackOutfitDetails(_ rackID: String,  completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getRackOutfit(rackID).urlRequest(completionBlock: completionBlock)
    }
    
    func createHighLight(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.createHighlight(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func getAllRacksExceptPrimary(_ completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.allRacksExceptPrimary.urlRequest(completionBlock: completionBlock)
    }
    
    func updateHighlights(_ parameters: [String: Any], completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.updateHighlights(parameters).urlRequest(completionBlock: completionBlock)
    }
    
    func getHighlightDetails(_ highlightId: String,  completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getHighLightsDetails(highlightId).urlRequest(completionBlock: completionBlock)
    }
    
    func getOwnOutfits(_ completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getOwnOutfits.urlRequest(completionBlock: completionBlock)
    }
    
    func deleteOwnOutfits(_ outfitId: String, completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.deleteOwnOutfit(outfitId).urlRequest(completionBlock: completionBlock)
    }
    
    func getMyHighlights(_ completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.getMyHighlights.urlRequest(completionBlock: completionBlock)
    }
    
    func likeOutfit(_ outfitId: String, completionBlock: @escaping ApiResponseCompletion) {
        AuthenticationApiServicesEndPoints.likeOutfit(outfitId).urlRequest(completionBlock: completionBlock)
    }
    
}
