//
//  HighlightResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 18/03/24.
//

import Foundation
struct HighlightResponseModel: Codable {
    let apiVer, message: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case apiVer = "api_ver"
        case message, statusCode
    }
}
