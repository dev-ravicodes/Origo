//
//  SingleHighLightResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 18/03/24.
//

import Foundation

//// MARK: - Welcome
//struct SingleHighLightResponseModel: Codable {
//    let statusCode: Int
//    let apiVer, message: String
//    let data: SingleHighLightResponseModelData
//    
//    enum CodingKeys: String, CodingKey {
//        case statusCode
//        case apiVer = "api_ver"
//        case message, data
//    }
//}
//
//// MARK: - DataClass
//struct SingleHighLightResponseModelData: Codable {
//    let v: Int
//    let name: String
//    let outfits: [HightLightOutfit]
//    let updatedAt, createdAt, id, userID: String
//    let visibility: Bool
//    
//    enum CodingKeys: String, CodingKey {
//        case v = "__v"
//        case name, outfits
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//        case id = "_id"
//        case userID = "userId"
//        case visibility
//    }
//}
//
//// MARK: - Outfit
//struct HightLightOutfit: Codable {
//    let userID, style, subCategory, createdAt: String
//    let updatedAt, season, id, description: String
//    let shares: String
//    let items: [Item]
//    let hangs: String
//    let v: Int
//    let linkToShop: [String]
//    
//    enum CodingKeys: String, CodingKey {
//        case userID = "userId"
//        case style, subCategory
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case season
//        case id = "_id"
//        case description, shares, items, hangs
//        case v = "__v"
//        case linkToShop
//    }
//}
//




//struct SingleHighLightResponseModel: Codable {
//    let data: SingleHighLightResponseModelData
//    let apiVer: String
//    let statusCode: Int
//    let message: String
//    
//    enum CodingKeys: String, CodingKey {
//        case data
//        case apiVer = "api_ver"
//        case statusCode, message
//    }
//}
//
//// MARK: - DataClass
//struct SingleHighLightResponseModelData: Codable {
//    let name, id: String
//    let outfits: [HightLightOutfit]
//}
//
////// MARK: - Outfit
//struct HightLightOutfit: Codable {
//    let outfitImages: [String]?
//    let id: String
//    
//    enum CodingKeys: String, CodingKey {
//        case outfitImages
//        case id = "_id"
//    }
//}
//

//struct SingleHighLightResponseModel: Codable {
//    let data: SingleHighLightResponseModelData
//    let message, apiVer: String
//    let statusCode: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case data, message
//        case apiVer = "api_ver"
//        case statusCode
//    }
//}
//
//// MARK: - DataClass
//struct SingleHighLightResponseModelData: Codable {
//    let name: String
//    let outfits: [HighLightOutfit]
//    let id: String
//}
//
//// MARK: - Outfit
//struct HighLightOutfit: Codable {
//    let image, id: String
//    
//    enum CodingKeys: String, CodingKey {
//        case image
//        case id = "_id"
//    }
//}


struct SingleHighLightResponseModel: Codable {
    let statusCode: Int
    let data: SingleHighLightResponseModelData
    let message, apiVer: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode, data, message
        case apiVer = "api_ver"
    }
}

// MARK: - DataClass
struct SingleHighLightResponseModelData: Codable {
    let name, updatedAt: String
    let outfits: [Outfit]
    let createdAt, id: String
    let visibility: Bool
    let v: Int
    let userID: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case updatedAt = "updated_at"
        case outfits
        case createdAt = "created_at"
        case id = "_id"
        case visibility
        case v = "__v"
        case userID = "userId"
    }
}

// MARK: - Outfit
struct HighLightOutfit: Codable {
    let outfitImages: [String]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case outfitImages
        case id = "_id"
    }
}
