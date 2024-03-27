//
//  OneRackDetailsResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/03/24.
//

//import Foundation
//struct OneRackDetailsResponseModel: Codable {
//    let statusCode: Int
//    let message: String
//    let data: RackData
//    let apiVer: String
//    
//    enum CodingKeys: String, CodingKey {
//        case statusCode, message, data
//        case apiVer = "api_ver"
//    }
//}
//
//// MARK: - DataClass
//struct RackData: Codable {
//    let outfits: [Outfit]
//}
//
//// MARK: - Outfit
//struct RackOutfit: Codable {
//    let image: String
//    let id: String
//    
//    enum CodingKeys: String, CodingKey {
//        case image
//        case id = "_id"
//    }
//}
//
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

//// MARK: - Welcome
//struct OneRackDetailsResponseModel: Codable {
//    let data: RackData
//    let apiVer, message: String
//    let statusCode: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case data
//        case apiVer = "api_ver"
//        case message, statusCode
//    }
//}
//
//// MARK: - DataClass
//struct RackData: Codable {
//    let id, name: String
//    let outfits: [RackOutfit]
//}
//
//// MARK: - Outfit
//struct RackOutfit: Codable {
//    let outfitImages: [String]
//    let id: String
//
//    enum CodingKeys: String, CodingKey {
//        case outfitImages
//        case id = "_id"
//    }
//}


struct OneRackDetailsResponseModel: Codable {
    let statusCode: Int
    let message, apiVer: String
    let data: RackData
    
    enum CodingKeys: String, CodingKey {
        case statusCode, message
        case apiVer = "api_ver"
        case data
    }
}

// MARK: - DataClass
struct RackData: Codable {
    let type, id, userID, updatedAt: String
    let visibility: Bool
    let name: String
    let outfits: [RackOutfit]
    let v: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case id = "_id"
        case userID = "userId"
        case updatedAt = "updated_at"
        case visibility, name, outfits
        case v = "__v"
        case createdAt = "created_at"
    }
}

// MARK: - Outfit
struct RackOutfit: Codable {
    let id: String
    let outfitImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case outfitImages
    }
}
