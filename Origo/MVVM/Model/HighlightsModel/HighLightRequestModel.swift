//
//  HighLightRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 18/03/24.
//

import Foundation
struct HighLightRenameRequestModel: Codable {
    var highlightId: String?
    var highlightName: String?
    
    enum CodingKeys: String, CodingKey {
        case highlightId, highlightName
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}
struct UpdateHighLightsRemoveOutfitsRequestModel: Codable {
    var highlightId: String?
    var outfitId: [String]?
    
    enum CodingKeys: String, CodingKey {
        case highlightId, outfitId
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}


struct UpdateHighLightRemoveRequestModel: Codable {
    var highlightId: String?
    var delete: Bool?
    
    enum CodingKeys: String, CodingKey {
        case highlightId, delete
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}
