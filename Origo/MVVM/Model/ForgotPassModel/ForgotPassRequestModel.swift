//
//  ForgotPassRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import Foundation
struct ForgotPassRequestModel: Codable {
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case email
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    
    var validationMessage: String? {
        if (email ?? "").isBlank {
            return .enterEmail
        }else if email?.checkIsValidEmail() == false{
            return .enterValidEmail
        }
        return nil
    }
    
}
