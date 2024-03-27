//
//  SignUpResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import Foundation

struct SignUpResponseModel: Codable {
    let statusCode: Int
    let apiVer, message: String
    let data: UserData
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case apiVer = "api_ver"
        case message, data
    }
}


// MARK: - Tokens
struct Tokens: Codable {
    let jwt, fcmToken, deviceID: String
    let deviceType: Int
    
    enum CodingKeys: String, CodingKey {
        case jwt, fcmToken
        case deviceID = "deviceId"
        case deviceType
    }
}
