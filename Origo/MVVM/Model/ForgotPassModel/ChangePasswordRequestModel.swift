//
//  ChangePasswordRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 07/02/24.
//

import Foundation
struct ChangePasswordRequestModel: Codable {
    var email: String?
    var password: String?
    var conPass: String?
    
    enum CodingKeys: String, CodingKey {
        case email, password
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    
    var validationMessage: String? {
        if (password ?? "").isBlank {
            return .enterPassword
        }else if password?.trim().count ?? 0 < 8{
            return .enterPasswordVal
        }
        else if password?.checkIsValidPassword() == false {
            return .enterValidPassword
        }
        else if (conPass ?? "").isBlank {
            return .enterConPassword
        }
        else if password != conPass {
            return .enterSameAsPassword
        }
        return nil
    }
    
}
