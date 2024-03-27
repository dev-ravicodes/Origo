//
//  UploadFIleResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 28/02/24.
//

import Foundation

struct UploadImageResponseModel : Codable {
    let statusCode : Int?
    let api_ver : String?
    let message : String?
    var data : UploadImageData?
    
    enum CodingKeys: String, CodingKey {
        
        case statusCode = "statusCode"
        case api_ver = "api_ver"
        case message = "message"
        case data = "data"
    }
    
}

struct UploadImageData : Codable {
    var fileUrl : String?
    
    enum CodingKeys: String, CodingKey {
        
        case fileUrl = "fileUrl"
    }
    
}
struct UploadImageArrResponseModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: [String]?

    enum CodingKeys: String, CodingKey {
        case statusCode, message
        case data
    }
}

struct UploadProductImageArrResponseModel: Codable {
    var statusCode: Int?
    var message: String?
    var data: UploadProductImageModel?

    enum CodingKeys: String, CodingKey {
        case statusCode, message
        case data
    }
}

struct UploadProductImageModel: Codable {
    var thumbnail: String?
    var urls: [String]?

    enum CodingKeys: String, CodingKey {
        case thumbnail
        case urls
    }
}
