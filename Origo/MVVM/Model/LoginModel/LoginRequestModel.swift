//
//  LoginRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import UIKit

struct LoginRequestModel: Codable {
    var email: String?
    var password: String?
    
    enum CodingKeys: String, CodingKey {
        case email, password
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
        else if (password ?? "").isBlank {
            return .enterPassword
        }
        return nil
    }
    
}
