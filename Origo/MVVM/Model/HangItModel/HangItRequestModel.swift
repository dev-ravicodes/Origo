//
//  HangItRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/03/24.
//

import Foundation
struct HangItRequestModel: Codable {
    var rackId: String?
    var outfitId: String?
    
    enum CodingKeys: String, CodingKey {
        case rackId, outfitId
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}


struct AddToRackRequestModel: Codable {
    var rackId: String?
    var rackName: String?
    
    enum CodingKeys: String, CodingKey {
        case rackId, rackName
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}
