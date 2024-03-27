//
//  OutFitsRecommendationResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 08/02/24.
//

import Foundation

struct OutFitsRecommendationResponseModel: Codable {
    let statusCode: Int
    let apiVer, message: String
    var data: OutfitsData
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case apiVer = "api_ver"
        case message, data
    }
}

struct OutfitsData: Codable {
    let perPage, currentPage: Int
    var data: [FitsItems]
    let total, totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case currentPage = "current_page"
        case data, total
        case totalPages = "total_pages"
    }
}

struct FitsItems: Codable {
    let id: String
    let image: String
    var isSelected = false

    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image
    }
}
