//
//  GetOutFitTypeModel.swift
//  Origo
//
//  Created by iTechnolabs on 15/03/24.
//

import Foundation

struct OutfitCategoryResponse: Codable {

    var statusCode: Int?
    var apiVer: String?
    var message: String?
    var data: OutfitCategoryData?

    private enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case apiVer = "api_ver"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        apiVer = try values.decodeIfPresent(String.self, forKey: .apiVer)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(OutfitCategoryData.self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(statusCode, forKey: .statusCode)
        try container.encodeIfPresent(apiVer, forKey: .apiVer)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(data, forKey: .data)
    }

}

struct OutfitCategoryData: Codable {

    var total: Int?
    var currentPage: Int?
    var totalPages: Int?
    var perPage: Int?
    var outfitCategory: [OutfitCategory]?

    private enum CodingKeys: String, CodingKey {
        case total = "total"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case perPage = "per_page"
        case outfitCategory = "outfitCategory"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
        outfitCategory = try values.decodeIfPresent([OutfitCategory].self, forKey: .outfitCategory)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(total, forKey: .total)
        try container.encodeIfPresent(currentPage, forKey: .currentPage)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
        try container.encodeIfPresent(perPage, forKey: .perPage)
        try container.encodeIfPresent(outfitCategory, forKey: .outfitCategory)
    }

}

struct OutfitCategory: Codable {

    var Id: String?
    var category: String?
    var _v: Int?
    var createdAt: String?
    var updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case Id = "_id"
        case category = "category"
        case _v = "__v"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Id = try values.decodeIfPresent(String.self, forKey: .Id)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        _v = try values.decodeIfPresent(Int.self, forKey: ._v)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(Id, forKey: .Id)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(_v, forKey: ._v)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(updatedAt, forKey: .updatedAt)
    }

}


struct OutfitColorResponse: Codable {

    var statusCode: Int?
    var apiVer: String?
    var message: String?
    var data: OutfitColorData?

    private enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case apiVer = "api_ver"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        apiVer = try values.decodeIfPresent(String.self, forKey: .apiVer)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(OutfitColorData.self, forKey: .data)
    }

}


struct OutfitColorData: Codable {

    var total: Int?
    var currentPage: Int?
    var totalPages: Int?
    var perPage: Int?
    var outfitColor: [OutfitColor]?

    private enum CodingKeys: String, CodingKey {
        case total = "total"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case perPage = "per_page"
        case outfitColor = "outfitColor"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
        outfitColor = try values.decodeIfPresent([OutfitColor].self, forKey: .outfitColor)
    }

}

struct OutfitColor: Codable {

    var Id: String?
    var color: String?
    var _v: Int?
    var createdAt: String?
    var updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case Id = "_id"
        case color = "color"
        case _v = "__v"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Id = try values.decodeIfPresent(String.self, forKey: .Id)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        _v = try values.decodeIfPresent(Int.self, forKey: ._v)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}


struct OutfitMaterialResponse: Codable {

    var statusCode: Int?
    var apiVer: String?
    var message: String?
    var data: OutfitMaterialData?

    private enum CodingKeys: String, CodingKey {
        case statusCode = "statusCode"
        case apiVer = "api_ver"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        apiVer = try values.decodeIfPresent(String.self, forKey: .apiVer)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(OutfitMaterialData.self, forKey: .data)
    }

}


struct OutfitMaterialData: Codable {

    var total: Int?
    var currentPage: Int?
    var totalPages: Int?
    var perPage: Int?
    var outfitMaterial: [OutfitMaterial]?

    private enum CodingKeys: String, CodingKey {
        case total = "total"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case perPage = "per_page"
        case outfitMaterial = "outfitMaterial"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
        perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
        outfitMaterial = try values.decodeIfPresent([OutfitMaterial].self, forKey: .outfitMaterial)
    }

}

struct OutfitMaterial: Codable {

    var Id: String?
    var material: String?
    var _v: Int?
    var createdAt: String?
    var updatedAt: String?

    private enum CodingKeys: String, CodingKey {
        case Id = "_id"
        case material = "material"
        case _v = "__v"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Id = try values.decodeIfPresent(String.self, forKey: .Id)
        material = try values.decodeIfPresent(String.self, forKey: .material)
        _v = try values.decodeIfPresent(Int.self, forKey: ._v)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}
