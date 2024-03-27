//
//  GetAllOutfitsRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 19/03/24.
//

import Foundation

struct GetAllOutfitsRequestModel: Codable {
    var search: String?
    var minRange: String?
    var maxRange: String?
    
    enum CodingKeys: String, CodingKey {
        case search, minRange, maxRange
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }

}
