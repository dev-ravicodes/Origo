//
//  VerifyForgotPassOtpRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 07/02/24.
//

import Foundation

struct VerifyPasswordOtpRequestModel: Codable {
    var email: String?
    var otp: String?
    
    enum CodingKeys: String, CodingKey {
        case email, otp
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    
    var validationMessage: String? {
        if (otp ?? "").isBlank {
            return .enterPassword
        }
        return nil
    }
    
}
