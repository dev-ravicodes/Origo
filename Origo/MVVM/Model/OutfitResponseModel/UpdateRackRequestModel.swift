////
////  UpdateRackRequestModel.swift
////  Origo
////
////  Created by iTechnolabs - 7 on 06/03/24.
////

import Foundation

struct UpdateRackRequestModel: Codable {
    var rackId: String?
    var visibility: Bool?
    
    enum CodingKeys: String, CodingKey {
        case rackId, visibility
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}

struct UpdateRackRemoveRequestModel: Codable {
    var rackId: String?
    var delete: Bool?
    
    enum CodingKeys: String, CodingKey {
        case rackId, delete
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}

struct UpdateRackRemoveOutfitsRequestModel: Codable {
    var rackId: String?
    var outfitId: [String]?
    
    enum CodingKeys: String, CodingKey {
        case rackId, outfitId
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}


struct UpdateRackRenameRequestModel: Codable {
    var rackId: String?
    var rackName: String?
    
    enum CodingKeys: String, CodingKey {
        case rackId, rackName
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    var validationMessage: String? {
        if (rackName ?? "").isBlank {
            return .rackName
        }
        
        return nil
    }
    
}
