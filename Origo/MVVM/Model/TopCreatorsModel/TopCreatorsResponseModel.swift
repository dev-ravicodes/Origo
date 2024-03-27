//
//  TopCreatorsResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 08/02/24.
//

import Foundation
struct TopCreatorsResponseModel: Codable {
    let message: String
    let data: TopCreatorsData
    let apiVer: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case message, data
        case apiVer = "api_ver"
        case statusCode
    }
}

// MARK: - DataClass
struct TopCreatorsData: Codable {
    var name: String?
    var outfitCount: String?
    var avatar: String?
}
