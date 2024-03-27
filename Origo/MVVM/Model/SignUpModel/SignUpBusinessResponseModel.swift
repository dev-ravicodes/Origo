//
//  SignUpBusinessResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 07/02/24.
//

import Foundation

// MARK: - Welcome
struct SignUpBusinessResponseModel: Codable {
    let message: String
    let data: UserData
    let apiVer: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case message, data
        case apiVer = "api_ver"
        case statusCode
    }
}

// MARK: - DataClass
struct SignUPBusinessData: Codable {
    let user: BusinessUser
    let token: String
}

// MARK: - User
struct BusinessUser: Codable {
    let password, accountType, email, businessName: String
    let avatar: String
    let v: Int
    let tokens: Tokens
    let otp: Otp
    let webLink: String
    let isDeleted: Int
    let profilePicture, userName, aboutInfo: String
    let address: Address
    let createdAt, updatedAt, id: String
    
    enum CodingKeys: String, CodingKey {
        case password, accountType, email, businessName, avatar
        case v = "__v"
        case tokens, otp, webLink
        case isDeleted = "is_deleted"
        case profilePicture, userName, aboutInfo, address
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id = "_id"
    }
}
