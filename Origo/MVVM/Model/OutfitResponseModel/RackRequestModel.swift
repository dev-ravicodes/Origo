//
//  RackRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/03/24.
//

import Foundation

struct RackRequestModel: Codable {
    var name: String?
    var outfits: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name, outfits
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    var validationMessage: String? {
        if (name ?? "").isBlank {
            return .validName
        }
        return nil
    }
    
}
