//
//  SignUpBusinessRequestModel.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 07/02/24.
//


import Foundation
import UIKit

struct SignUpBusinessRequestModel: Codable {
    var businessName: String?
    var userName: String?
    var email: String?
    var password: String?
    var webLink: String?
    var accountType: String?
    var address: SignUpAddress?
    var conPass: String?
    
    enum CodingKeys: String, CodingKey {
        case businessName, userName , email, password, webLink, accountType, address
    }
    
    var json: [String: Any] {
        let dictionary: [String: Any] = JSONEncoder().convertToDictionary(self) ?? [:]
        return dictionary
    }
    
    var image = UIImage(named: AppConstants.rememberMe)
    var selectedImage = UIImage(named: AppConstants.rememberCheck)
    
    var validationMessage: String? {
        if (businessName ?? "").isBlank {
            return .enterBusinessName
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
        else if !(webLink ?? "").isBlank {
            if webLink?.isValidURL == false {
                return .validWebLink
            }
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

