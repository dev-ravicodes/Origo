//
//  String+Extension.swift
//  TimeApp
//
//  Created by Kamaljeet Punia on 04/05/20.
//  Copyright © 2020 Tina. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func eliminateDoubleForwardSlashes() -> String {
        return self.replacingOccurrences(of: "//", with: "/")
    }
    
    var htmlStripped : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func addPercentEncoding()->String?{
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    func containsAllZeroes() -> Bool {
        let finalString = replacingOccurrences(of: ".", with: "")
        for char in finalString {
            if char != "0" {
                return false
            }
        }
        return true
    }
    
    func containAllZeroes() -> Bool {
        let finalString = replacingOccurrences(of: ".", with: "")
        for char in finalString {
            if char != "0" || char != "$" {
                return false
            }
        }
        return true
    }

    
    var isEmptyWithTrimmedSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var url: URL? {
        return URL(string: self)
    }
   
    func checkIsValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func checkIsValidName() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Za-z ]+$", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, count)) != nil {
            return true
        } else {
            return false
        }
    }

    
    func checkIsValidPassword() -> Bool {
        let regex = try! NSRegularExpression(pattern: #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#, options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, count)) != nil {
            return true
        }else{
            return false
        }
    }
    
        
    func localized() -> String{
        return NSLocalizedString(self, comment: self)
    }
    
    func trim() -> String{
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func trimAll() -> String {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    func toDate(withFormat format:String)-> Date?{
        
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.locale = Locale.current
//        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
    }
    
    func getFormattedDate(withFormat format:DateFormat, toFormat:DateFormat) -> String {
        if self.trim().count > 0{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format.rawValue
            let date = dateFormatter.date(from: self)
            dateFormatter.dateFormat = toFormat.rawValue
            return dateFormatter.string(from: date!)
        }
        return "-"
    }
    
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    func toImage()->UIImage{
        let imageData = Data(base64Encoded: self)
        let image = UIImage(data: imageData ?? Data())
        return image ?? UIImage()
    }
    
    func toFloat() -> Float{
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: App.locale)
        let number = numberFormatter.number(from: self)
        let numberFloatValue = number?.floatValue
        return numberFloatValue ?? 0.00
    }
    
    func setTailingDigits() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: App.locale)
        formatter.numberStyle = .decimal
        let cleanedString = self.replacingOccurrences(of: ",", with: "") //changes 7,649  to 7649 
        return formatter.string(from: NSNumber(value: Float(cleanedString) ?? 0)) ?? "0.00"
    }
}

extension Float{
    func setTailingDigits() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: App.locale)
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "0.00"
    }
    
    func toString() -> String{
        return "\(self)"
    }
}
