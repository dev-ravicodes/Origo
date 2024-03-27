//
//  GetAllOutfitsModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 28/02/24.
//

import Foundation

//// MARK: - Welcome
//struct GelAllOutfitsResponseModel: Codable {
//    let statusCode: Int
//    let apiVer, message: String
//    var data: AllOutfitsData
//    
//    enum CodingKeys: String, CodingKey {
//        case statusCode
//        case apiVer = "api_ver"
//        case message, data
//    }
//}
//
//// MARK: - DataClass
//struct AllOutfitsData: Codable {
//    let total, currentPage, totalPages, perPage: Int
//    var data: [OutfitsItems]
//    
//    enum CodingKeys: String, CodingKey {
//        case total
//        case currentPage = "current_page"
//        case totalPages = "total_pages"
//        case perPage = "per_page"
//        case data
//    }
//}
//
//// MARK: - Datum
//struct OutfitsItems: Codable {
//    let id, subCategory, season, style: String
//    let userID: UserID
//    let description: String
//    var items: [Item]
//    let linkToShop: [String]
//    let hangs, shares, createdAt, updatedAt: String
//    let v: Int
//    var iSelected: Bool = false
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case subCategory, season, style
//        case userID = "userId"
//        case description, items, linkToShop, hangs, shares
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case v = "__v"
//    }
//}
//
//// MARK: - Item
//struct Item: Codable {
//    let name, type, color, brand: String
//    let material, model: String
//    let image: [String]
//    let id: String
//    var count: String?
//    var isSelected: Bool? = false
//    
//    enum CodingKeys: String, CodingKey {
//        case name, type, color, brand, material, model, image
//        case id = "_id"
//    }
//}
//
//// MARK: - UserID
//struct UserID: Codable {
//    let id, userName: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case userName
//    }
//}
//


struct GelAllOutfitsResponseModel: Codable {
    let statusCode: Int
    let apiVer, message: String
    var data: AllOutfitsData
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case apiVer = "api_ver"
        case message, data
    }
}

// MARK: - DataClass
struct AllOutfitsData: Codable {
    let total, currentPage, totalPages, perPage: Int
    var data: [OutfitsItems]
    
    enum CodingKeys: String, CodingKey {
        case total
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case perPage = "per_page"
        case data
    }
}

// MARK: - Datum

struct OutfitsItems: Codable {
    let id, subCategory, season, style: String
    let styleName: String
    let userID: UserID
    let description: String
    let outfitImages: [String]
    let linkToShop: [String]
    let rankingType, hangs, shares: String
    var items: [Item]
    let createdAt, updatedAt: String
    let v: Int
    var iSelected: Bool = false
    var addGesture: Bool = false

    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case subCategory, season, style, styleName
        case userID = "userId"
        case description, outfitImages, linkToShop, rankingType, hangs, shares, items
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case v = "__v"
    }
}

// MARK: - Item
struct Item: Codable {
    let name, type, color, brand: String
    let material, model: String
    let image: [String]
    let url, id: String
    var isSelected: Bool? = false

    
    enum CodingKeys: String, CodingKey {
        case name, type, color, brand, material, model, image, url
        case id = "_id"
    }
}

// MARK: - UserID
struct UserID: Codable {
    let id, fullName, userName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName, userName
    }
}
