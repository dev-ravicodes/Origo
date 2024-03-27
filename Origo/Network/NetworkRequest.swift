//
//  NetworkRequest.swift
//  Whetness
//
//  Created by Kamaljeet Punia on 22/09/20.
//  Copyright © 2020 Kamaljeet Punia. All rights reserved.
//


import Foundation

public struct HTTPMethodType: RawRepresentable, Equatable, Hashable {
    
    /// `DELETE` method.
    public static let delete = HTTPMethodType(rawValue: "DELETE")
    /// `GET` method.
    public static let get = HTTPMethodType(rawValue: "GET")
    public static let post = HTTPMethodType(rawValue: "POST")
    /// `PUT` method.
    public static let put = HTTPMethodType(rawValue: "PUT")
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public enum URLEncodingType{
    case FORM
    case QUERY
    case JSONENCODING
    case FileUpload
    case URLENCODING
}

public enum NetworkErrorReason: Error {
    case FailureErrorCode(code: Int, message: String)
    case InternetNotReachable
    case UnAuthorizedAccess
    case Other
}

public enum MimeType: String {
    case image = "image/png"
    case video = "video/mp4"
    case liveImg = ""
    case audio = "audio/mp3"
    case pdf = "application/pdf"
    case rtf = "application/rtf"
    case docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    case xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
}

public enum MultipartUploadType {
    case data
    case url
}

enum ApiResultType {
    case json
    case data
}

struct Resource {
    let method: HTTPMethodType
    let parameters: [String : Any]?
    let arrParameters: [[String : Any]]?
    let encoding: URLEncodingType
    let headers: [String:Any]?
    let validator: APIResultValidatorApi?
    let responseType: ApiResultType
}

protocol APIService {
    var path: String { get }
    var resource: Resource { get }
}

extension APIService {
    func urlRequest(completionBlock: @escaping ApiResponseCompletion) {
        //We can chanage this alamofire dependency any time.
        AlamofireNetworkManager().urlRequest(path: self.path, resource: self.resource, completionBlock: completionBlock)
    }
    
    func request(completionBlock: @escaping ApiResponseCompletion) {
        AlamofireNetworkManager().request(path: self.path, resource: self.resource, completionBlock: completionBlock)
    }
    
    func requestMultipart(modelArray: MultipartModel?=nil, arrMultipart:[MultipartModel]?=nil, uploadType: MultipartUploadType, completionBlock: @escaping ApiResponseCompletion) {
        AlamofireNetworkManager().multipartRequest(path: self.path, resource: self.resource, modelArray: modelArray, arrMultipart:arrMultipart, uploadType: uploadType, completionBlock: completionBlock)
    }
}
