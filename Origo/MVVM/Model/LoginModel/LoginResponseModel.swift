//
//  LoginResponseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import Foundation

// MARK: - Welcome
struct LoginResponseModel: Codable {
    let data: UserData
    let message: String
    let statusCode: Int
    let apiVer: String
    
    enum CodingKeys: String, CodingKey {
        case data, message, statusCode
        case apiVer = "api_ver"
    }
}

// MARK: - DataClass
struct UserData: Codable {
    let token: String
    let user: User
    let rackID: String
    
    enum CodingKeys: String, CodingKey {
        case token, user
        case rackID = "rackId"
    }
}

// MARK: - User
struct User: Codable {
    let userName: String
    let v: Int
    let aboutInfo, id: String
    let isDeleted: Int
    let password, tokens, avatar, updatedAt: String
    let fullName, accountType: String
    let otp: Otp
    let email: String
    let address: Address
    let webLink, createdAt, profilePicture, businessName: String
    let dob: String
    
    enum CodingKeys: String, CodingKey {
        case userName
        case v = "__v"
        case aboutInfo
        case id = "_id"
        case isDeleted = "is_deleted"
        case password, tokens, avatar
        case updatedAt = "updated_at"
        case fullName, accountType, otp, email, address, webLink
        case createdAt = "created_at"
        case profilePicture, businessName, dob
    }
}

// MARK: - Address
struct Address: Codable {
    let city, state, country: String
    let coordinates: Coordinates
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Otp
struct Otp: Codable {
    let changePassword, forgotPassword: String
    let forgotVerified: Int
}
