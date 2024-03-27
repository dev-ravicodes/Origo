//
//  Gradient Button.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import Foundation
import UIKit

enum APIEnvironment{
    case development
    case production
    case staging
}

struct App {
    
    static let name = "Origo"
    static let deviceType = "iOS"
    static let screenSize = UIScreen.main.bounds
    static let locale = "en_US"
    static let limitTxtViwDesc = 2000

    struct Keys {
//        static let CardScan = "vh"
    }

}

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
var selectedCountryId = String()
var isCurrentMilestone = true
var isSubscriptionPurchased = false

struct AppConstants {
    //App environment
    static let environment: APIEnvironment = .development
    static let InvisibleSign = "\u{200B}"
    static var mitreID : String?
    static var hangerID : String?
    static var paymentToken : String?
    static var contractID : String?
    static var templateID : String?
    static var forgetType = "forgot"
    static var verifyType = "verify"
    static var userId: String?
    static var showPass = "ic_showPass"
    static var hidePass = "ic_hidePass"
    static var rememberCheck = "ic_RememberCheck"
    static var rememberMe = "ic_rememberMe"
    static var googlePlacesAPIKey: String {
        return "pk.eyJ1IjoibXlqb2lubWUiLCJhIjoiY2xycHFkZXZyMDhtMjJpa3lvaXg3eWFsZCJ9.liZHUG7aNLDLeIb7hDc8tA"
    }
    static var photoRoomAPIKey: String {
        return "d20a60775dfed6ce5f5035108d466ad2a114a7b5"
    }
    
    static func getMitreStylesURL(mitreId:String?)->String{
        return "additionalPart?additionalPartTypeId=\(mitreId ?? "")"
    }
    
    static func getHangerTypesURL(hangerId:String?)->String{
        return "additionalPart?additionalPartTypeId=\(hangerId ?? "")"
    }
    
    struct Mitres{
        static let ninetyInside = "90° Inside Mitres"
        static let ninetyOutside = "90° Outside Mitres"
        static let bayInside = "Bay Inside Mitres"
        static let bayOutside = "Bay Outside Mitres"
        static let customMitre = "Custom Mitres"
    }
    
    //Base url
    struct Urls {

        static var apiBaseUrl: String {
            switch AppConstants.environment {
            case .development:
                return "https://origo-backend-stag.itechnolabs.tech/api/v1/"
            case .production:
                return "https://origo-backend-stag.itechnolabs.tech/api/v1/" // LIVE URL
            case .staging:
                return "https://origo-backend-stag.itechnolabs.tech/api/v1/"
            }
        }
        
        static var paymentURL:String{
            switch AppConstants.environment{
            case .production:
                return "https://cliq.gutterapplication.com"
            default:
                return "https://dev-cliq.itechnolabs.tech"
            }
        }
        
        
        
    }

    //User default keys
    struct UserDefault {
        static let currentUser = "currentUser"
        static let user_id = "user_id"
        static let communityData = "communityData"
        static let homeStoriesData = "homeStoriesData"
        static let firstTimeData = "FirstTimetutorial"
        static let loginDetail = "loginDetail"
        static let rememberMe = "rememberMe"
        static let newUser = "newUser"
        static let showGuidelines = "showGuidelines"
    }
    
    struct FirebaseConsts {
        static var ImagePath = "chats/"
        static var chatsCollection = "chats"
        static var imageAttachment = "Attachment: Image"
        static var messagesCollection = "messages"
    }
}

enum vcType{
    case subCategory
    case products
    case service
}

var firebaseToken: String {
    return "firebase_token"
}

extension Notification.Name {
    static var endCallNotification = Notification.Name("EndCallNotification")
}

var uniqueIntIdKey: String {
    return "uniqueIntId"
}

enum NotificationAction {
    static let addComment = "post_comment"
    static let addCommentReply = "comment_reply"
    static let follow = "follow"
    static let likeComment = "comment_like"
    static let likePost = "post_like"
    static let message = "message"
    static let audioCall = "Audio_call"
    static let videoCall = "Video_call"
}

enum DateFormat:String{
    case dmy = "dd-MM-yyyy"
    case Mdy = "MM-dd-yyyy"
    case MMdy = "MMM dd, yyyy"
    case dMyHma = "dd, MMM yyyy h:mm a"
    case mdyHma = "MM/dd/yyyy h:mm a"
    case hma = "hh:mm a"
    case ymd = "yyyy-MM-dd"
    case dMy = "dd MMM, yyyy"
    case serverFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dMM = "dd MMM"
    case yMdHms = "yyyy-MM-dd HH:mm:ss"
    case Hm = "HH:mm"
    case dmmmy="d MMM, yyyy"
}

enum Gif: String {
    case ic_SwipeRight, ic_SwipeLeft, ic_Hanger, ic_Next, ic_ScrollUp
}

enum FilterType : String {
    case Chrome = "CIPhotoEffectChrome"
    case Fade = "CIPhotoEffectFade"
    case Instant = "CIPhotoEffectInstant"
    case Mono = "CIPhotoEffectMono"
    case Noir = "CIPhotoEffectNoir"
    case Process = "CIPhotoEffectProcess"
    case Tonal = "CIPhotoEffectTonal"
    case Transfer =  "CIPhotoEffectTransfer"
}
