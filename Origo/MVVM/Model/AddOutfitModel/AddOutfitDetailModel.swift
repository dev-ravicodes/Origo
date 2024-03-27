//
//  AddOutfitDetailModel.swift
//  Origo
//
//  Created by iTechnolabs on 15/03/24.
//

import Foundation

struct AddOutfitDetailModel: Codable {
    
    var season: String?
    var style: String?
    var styleName: String?
    var description: String?
    var items: [AddOutfitDetailItems]?
    var outfitImages: [String]?
    var rankingType: String?
    
    enum CodingKeys: String, CodingKey {
        case season,
             style,
             styleName,
             description,
             items,
             rankingType,
             outfitImages
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
}

struct AddOutfitDetailItems: Codable {
    var name: String?
    var type: String?
    var color: String?
    var brand: String?
    var material: String?
    var model: String?
    var image: [String]?
    var url: String?
    var isSelected = false
    enum CodingKeys: String, CodingKey {
        case name,
             type,
             color,
             brand,
             material,
             model,
             image,
             url
    }

}
