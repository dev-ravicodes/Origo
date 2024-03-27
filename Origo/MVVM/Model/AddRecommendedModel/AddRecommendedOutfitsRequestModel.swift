//
//  AddRecommendedOutfitsRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 26/02/24.
//

import Foundation

struct AddRecommendedOutfitsRequestModel: Codable {
    var outFitIds: [String]?
    
    enum CodingKeys: String, CodingKey {
        case outFitIds
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}
