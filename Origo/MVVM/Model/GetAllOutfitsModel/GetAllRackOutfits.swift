//
//  GetAllRackOutfits.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/03/24.
//

import Foundation


//struct GetAllRacksOutfitsModel: Codable {
//    let statusCode: Int
//    let apiVer, message: String
//    var data: RackDataClass
//    
//    enum CodingKeys: String, CodingKey {
//        case statusCode
//        case apiVer = "api_ver"
//        case message, data
//    }
//}
//
//// MARK: - DataClass
//struct RackDataClass: Codable {
//    var outfits: [FitsItems]
//}

// MARK: - Outfit
//struct RacksOutfit: Codable {
//    let id: String
//    let image: String
//    var isSelected: Bool = false
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case image
//    }
//}



// MARK: - Welcome
struct GetAllRacksOutfitsModel: Codable {
    let message, apiVer: String
    let statusCode: Int
    var data: RackDataClass
    
    enum CodingKeys: String, CodingKey {
        case message
        case apiVer = "api_ver"
        case statusCode, data
    }
}

// MARK: - DataClass
struct RackDataClass: Codable {
    var outfits: [Outfit]
    let userID, id, name: String
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case outfits
        case userID = "userId"
        case id = "_id"
        case name
    }
}

//// MARK: - Outfit
//struct Outfit: Codable {
//    let outfitImages: [String]
//    let id: String
//    
//    enum CodingKeys: String, CodingKey {
//        case outfitImages
//        case id = "_id"
//    }
//}
