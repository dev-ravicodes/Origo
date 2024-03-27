//
//  GetOutfitsDetailsResponse.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/03/24.
//

import Foundation

//// MARK: - Welcome
//struct GetOutfitsDetialsModel: Codable {
//    let apiVer: String
//    let statusCode: Int
//    let message: String
//    var data: OutfitsDetailsData
//    
//    enum CodingKeys: String, CodingKey {
//        case apiVer = "api_ver"
//        case statusCode, message, data
//    }
//}
//
//// MARK: - DataClass
//struct OutfitsDetailsData: Codable {
//    let style, description: String
//    let v: Int
//    let userID: UserIDDetails
//    let subCategory, id, updatedAt, shares: String
//    let createdAt, season: String
//    let linkToShop: [String]
//    let hangs: String
//    var items: [Item]
//    
//    enum CodingKeys: String, CodingKey {
//        case style, description
//        case v = "__v"
//        case userID = "userId"
//        case subCategory
//        case id = "_id"
//        case updatedAt = "updated_at"
//        case shares
//        case createdAt = "created_at"
//        case season, linkToShop, hangs, items
//    }
//}
//
////
////// MARK: - UserID
//struct UserIDDetails: Codable {
//    let userName, fullName, id: String
//    
//    enum CodingKeys: String, CodingKey {
//        case userName, fullName
//        case id = "_id"
//    }
//}



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

//import Foundation
//
//// MARK: - Welcome
//struct GetOutfitsDetialsModel: Codable {
//    let apiVer, message: String
//    let data: [OutfitsDetailsData]
//    let statusCode: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case apiVer = "api_ver"
//        case message, data, statusCode
//    }
//}
//
//// MARK: - Datum
//struct OutfitsDetailsData: Codable {
//    let type, updatedAt, id: String
//    let visibility: Bool
//    let userID: String
//    let v: Int
//    let createdAt, name: String
//    let outfits: [Outfit]
//    
//    enum CodingKeys: String, CodingKey {
//        case type
//        case updatedAt = "updated_at"
//        case id = "_id"
//        case visibility
//        case userID = "userId"
//        case v = "__v"
//        case createdAt = "created_at"
//        case name, outfits
//    }
//}

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


// MARK: - Welcome
struct GetOutfitsDetialsModel: Codable {
    let apiVer, message: String
    var data: OutfitsDetailsData
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case apiVer = "api_ver"
        case message, data, statusCode
    }
}

// MARK: - DataClass
//struct OutfitsDetailsData: Codable {
//    let userID: UserID
//    let season, id, description: String
//    let items: [Items]
//    let v: Int
//    let styleName, shares, subCategory, style: String
//    let rankingType: String
//    let linkToShop: [String]
//    let outfitImages: [String]
//    let updatedAt, createdAt, hangs: String
//    
//    enum CodingKeys: String, CodingKey {
//        case userID = "userId"
//        case season
//        case id = "_id"
//        case description, items
//        case v = "__v"
//        case styleName, shares, subCategory, style, rankingType, linkToShop, outfitImages
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//        case hangs
//    }
//}

struct OutfitsDetailsData: Codable {
    let userID: UserID
    let season, id, description: String
    var items: [Item]
    let v: Int
    let styleName, shares, subCategory, style: String
    let rankingType: String
    let linkToShop: [String]
    let outfitImages: [String]
    let updatedAt, createdAt, hangs: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case season
        case id = "_id"
        case description, items
        case v = "__v"
        case styleName, shares, subCategory, style, rankingType, linkToShop, outfitImages
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case hangs
    }
}

//// MARK: - UserID
//struct UserID: Codable {
//    let userName, id, fullName: String
//    
//    enum CodingKeys: String, CodingKey {
//        case userName
//        case id = "_id"
//        case fullName
//    }
//}
