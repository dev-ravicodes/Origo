//
//  ResendPasswordOtpRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 08/02/24.
//

import Foundation
struct ResendPasswordOtpRequestModel: Codable {
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case email
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
}
