//
//  EditProfileRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 28/02/24.
//

import Foundation

struct EditProfileRequestModel: Codable {
    var aboutInfo: String?
    var avatar: String?
    var profilePicture: String?
    var userName: String?
    
    enum CodingKeys: String, CodingKey {
        case aboutInfo, avatar, profilePicture, userName
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    var validationMessage: String? {
        if (userName ?? "").isBlank {
            return .username
        }

        return nil
    }
    
}
