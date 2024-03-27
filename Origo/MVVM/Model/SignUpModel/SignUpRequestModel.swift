//
//  SignUpRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import Foundation
import UIKit

struct SignUpAddress: Codable {
    var city: String?
    var state: String?
    var country: String?
    var coordinates: [Double]?
    enum CodingKeys: String, CodingKey {
        case city, state, country, coordinates
    }
}

struct SignUpRequestModel: Codable {
    var userName: String?
    var fullName: String?
    var email: String?
    var password: String?
    var dob: String?
    var accountType: String?
    var address: SignUpAddress?
    var conPass: String?
    
    enum CodingKeys: String, CodingKey {
        case userName, fullName, email, password, dob, accountType, address
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    
    var image = UIImage(named: AppConstants.rememberMe)
    var selectedImage = UIImage(named: AppConstants.rememberCheck)

    
    var validationMessage: String? {
        if (fullName ?? "").isBlank {
            return .enterFullName
        }
        else if fullName?.checkIsValidName() == false {
            return .validName
        }
        else if (userName ?? "").isBlank {
            return .username
        }
        else if (email ?? "").isBlank {
            return .enterEmail
        }
        else if email?.checkIsValidEmail() == false {
            return .enterValidEmail
        }
        else if (dob ?? "").isBlank {
            return .dob
        }
        else if (address?.city ?? "").isBlank {
            return .enterCountry
        }
        else if (address?.state ?? "").isBlank {
            return .enterState
        }
        else if (address?.country ?? "").isBlank {
            return .enterCountry
        }
        else if (password ?? "").isBlank {
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
        if let imageData1 = image?.pngData(), let imageData2 = selectedImage?.pngData() {
            if imageData1 != imageData2 {
                return .agreeTerms
            }
        }
        return nil
    }
    
}
