//
//  ResendPassOtpResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 08/02/24.
//

import Foundation
struct ResendPassOtpResponseModel: Codable {
    let statusCode: Int
    let apiVer, message: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case apiVer = "api_ver"
        case message
    }
}
