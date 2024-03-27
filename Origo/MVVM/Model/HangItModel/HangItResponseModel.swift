//
//  HangItResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/03/24.
//

import Foundation

struct HangItResponseModel: Codable {
    let data: DataClass
    let apiVer: String
    let statusCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case apiVer = "api_ver"
        case statusCode, message
    }
}

struct DataClass: Codable {
    let outfits: [String]
    let id: String
    let visibility: Bool
    let type, updatedAt, name: String
    let v: Int
    let createdAt, userID: String
    
    enum CodingKeys: String, CodingKey {
        case outfits
        case id = "_id"
        case visibility, type
        case updatedAt = "updated_at"
        case name
        case v = "__v"
        case createdAt = "created_at"
        case userID = "userId"
    }
}

