//
//  ProfileResonseModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 26/02/24.
//


import Foundation

// MARK: - Welcome
struct ProfileResonseModel: Codable {
    let message: String
    let data: ProfileData
    let apiVer: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case message, data
        case apiVer = "api_ver"
        case statusCode
    }
}

// MARK: - DataClass
struct ProfileData: Codable {
    let myHighlights: [MyHighlight]
    let hangerRecords: String
    let userProfile: UserProfile
    let mostLikedOutfits: [MostLikedOutfit]
}

// MARK: - MyHighlight
struct MyHighlight: Codable {
    let userID, updatedAt: String
    let visibility: Bool
    let id: String
    let outfits: [ProfileOutfit]
    let createdAt: String
    let v: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case updatedAt = "updated_at"
        case visibility
        case id = "_id"
        case outfits
        case createdAt = "created_at"
        case v = "__v"
        case name
    }
}

struct ProfileOutfit: Codable {
    let outfitImages: [String]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case outfitImages
        case id = "_id"
    }
}

// MARK: - UserProfile
struct UserProfile: Codable {
    let userName, status, avatar, aboutInfo: String
    let address: Address
    let id, fullName, createdAt, updatedAt: String
    let password, dob: String
    let v: Int
    let email, accountType, tokens, webLink: String
    let role, profilePicture: String
    let isDeleted: Int
    let otp: Otp
    let businessName: String
    
    enum CodingKeys: String, CodingKey {
        case userName, status, avatar, aboutInfo, address
        case id = "_id"
        case fullName
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case password, dob
        case v = "__v"
        case email, accountType, tokens, webLink, role, profilePicture
        case isDeleted = "is_deleted"
        case otp, businessName
    }
}

// MARK: - MostLikedOutfit
struct MostLikedOutfit: Codable {
    let outfitImages: [String]
    let season, id, userID, hangs: String
    let likes: String
    
    enum CodingKeys: String, CodingKey {
        case outfitImages, season
        case id = "_id"
        case userID = "userId"
        case hangs, likes
    }
}
