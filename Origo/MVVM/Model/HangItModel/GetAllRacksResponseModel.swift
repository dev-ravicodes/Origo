//
//  GetAllRacksResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/03/24.
//

import Foundation

//struct GetAllRacksResponseModel: Codable {
//    let statusCode: Int
//    var data: [AllRackData]
//    let apiVer, message: String
//    
//    enum CodingKeys: String, CodingKey {
//        case statusCode, data
//        case apiVer = "api_ver"
//        case message
//    }
//}
//
//
//// MARK: - Datum
//struct AllRackData: Codable {
//    let userID: String
//    let v: Int
//    let updatedAt, createdAt, id, name: String
//    let visibility: Bool
//    let type: String
//    var outfits: [Outfit]
//    
//    enum CodingKeys: String, CodingKey {
//        case userID = "userId"
//        case v = "__v"
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//        case id = "_id"
//        case name, visibility, type, outfits
//    }
//}

// MARK: - Outfit
struct Outfit: Codable {
    let id: String?
    let outfitImages: [String]
    var isSelected = false
    var section = Int()
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case outfitImages
    }
}


struct AllRacksWithoutPrimary: Codable {
    let statusCode: Int
    let apiVer, message: String
    let data: [AllRacksWithoutPrimaryData]
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case apiVer = "api_ver"
        case message, data
    }
}

// MARK: - DataClass
struct AllRacksWithoutPrimaryData: Codable {
    let id, name, userID: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case userID = "userId"
    }
}






import Foundation

// MARK: - Welcome
struct GetAllRacksResponseModel: Codable {
    let apiVer, message: String
    var data: [AllRackData]
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case apiVer = "api_ver"
        case message, data, statusCode
    }
}

// MARK: - Datum
struct AllRackData: Codable {
    let type, updatedAt, id: String
    let visibility: Bool
    let userID: String
    let v: Int
    let createdAt, name: String
    var outfits: [Outfit]
    
    enum CodingKeys: String, CodingKey {
        case type
        case updatedAt = "updated_at"
        case id = "_id"
        case visibility
        case userID = "userId"
        case v = "__v"
        case createdAt = "created_at"
        case name, outfits
    }
}

//// MARK: - Outfit
//struct Outfit: Codable {
//    let id: String
//    let outfitImages: [String]
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case outfitImages
//    }
//}
