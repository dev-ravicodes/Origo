//
//  Gradient Button.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import Foundation

enum LocalizedStringEnum:String {
    case appName = "Jiu Jitsu"
    case networkNotReachable
    case somethingWentWrong
    case sessionExpired

    //MARK:- Alerts
    case ok = "OK"
    case yes = "Yes"
    case no = "No"
    case add = "Add"
    case cancel = "Cancel"
    
    case logoutAlert = "Are you sure you want to logout?"
    case enterMessage = "Please enter message"
    case enterFullName = "Please enter full name"
    case enterValidEmail = "Please enter valid email"
    case forgotenterValidEmail = "Please enter email"
    case verifyOtp = "Please enter OTP"
    case invalidOtp = "Invalid OTP"
    case enterValidPassword = "Password should be minimum of 8 digits including alphanumeric with at least 1 digit and 1 special character"
    case enterPassword = "Please enter password"
    case passwordConfirmPassNotMatch = "Password and Confirm Password donot match"
    case confirmTerms
    
    case enterName = "Please enter name"
    case enterQuery = "Please enter query"
    case selectCategory = "Please select category"
    case enterFirstName = "Please enter first name"
    case enterBio = "Please enter your bio"
    case enterMarriedStatus = "Please enter your married status"
    case enterLocation = "Please enter your Location"
    
    case enterValidFirstName = "Numbers and special characters not allowed in first name"
    case enterValidLastName = "Numbers and special characters not allowed in last name"
    case enterValidBuisnnessName = "Numbers and special characters not allowed in business name"
    case enterLastName = "Please enter last name"
    case enterDisplayName
    case enterPhoneNo = "Please enter mobile number"
    case enterValidPhoneNo = "Please enter valid mobile number"
    case enterOldPassword = "Please enter old password"
    case enterConfirmPassword = "Please enter confirm password"
    case enteroldPasswordConfirmPassword = "old password Confirm password does't match"
    case enterNewPassword = "Please enter new password"
    case passwordNotMatch    = "Password doesnot match"
    
    case enterBuisnessName = "Please enter business name"
    case enterValidAddress = "Please enter address"
    case pleaseUploadBusinessImage = "Please upload your business image"
    case enterValidDesc = "Please enter Description"
    case enterMediaMsg = "Please select any one image, video or music file"
    case enterBroasdcastMsg = "Please select audio or record audio to broadcast"
    case enterAudioPostMsg = "Please select audio to post"
    
    case enterCommunityName = "Please enter community name"
    case enterValidCommunityName = "Numbers and special characters not allowed in community name"
    case blackImage = "Please Upload Black Image"
    case whiteImage = "Please Upload White Image"
    case selectMembers = "Please select members to add"
    case unblockUser = "Do you wants to unblock user?"
    case blockUser = "Do you wants to block user?"
    case removePost = "Do you wants to remove reported post?"
    case removecommunitymember = "Do you wants to remove member?"
    case resendOTP = "OTP has been sent successfully"
    case userIdcheck = "user id cannot blank"
    
    case selectIdentityProofType
    case selectIdentityProof
    
    case enterProfileName
    case enterAboutYou
    case uploadHeadshot
    case uploadBodyImage
    
    case bankName
    case enterAccHolderName
    case enterAccNumber
    case enterIfsc
    case enterRoutingNo
    
    case enterPostDescription
    case selectPostType
    case selectPaidType
    case enterAmount
    case chooseMedia
    case editProfile = "Edit Profile"
    case settings = "Settings"
    case logout = "Logout"
    case changePassword = "Change Password"
    case aboutUs = "About Us"
    case privacyPolicy = "Privacy Policy"
    case terms = "Terms & Conditions"
    case contactUs = "Contact Us"
    case know = "Know"
    case writeHere = "Write here..."
    case submitted = "Hey! Your today's report form has been submitted successfully."
    case todayReport = "VIEW TODAY'S REPORT"
    case continue1 = "CONTINUE"
    case clockIn = "Clock In"
    case clockOut = "Clock Out"
    case verifyYourEmail = "Please Verify Your Email"

    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}

