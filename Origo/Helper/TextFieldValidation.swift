//
//  TextFieldValidation.swift
//  Gutter
//
//  Created by Dev Team on 30/03/23.
//

import UIKit

class TextFieldValidation {
    //validation decimal digits to 2
    static func restrictDecimalsTo2Digits(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        let existingText = textField.text ?? ""
        let replacementText = (existingText as NSString).replacingCharacters(in: range, with: string)
        
        if decimalSeparator == "," {
            textField.text = replacementText.replacingOccurrences(of: ",", with: ".")
            return false
        } else {
            guard let oldText = textField.text, let r = Range(range, in: oldText) else {
                return true
            }
            
            let newText = oldText.replacingCharacters(in: r, with: string)
//            let isNumeric = !newText.isEmpty || (Double(newText) != nil)
            let numberOfDots = newText.components(separatedBy: ".").count - 1
            
            let numberOfDecimalDigits: Int
            if let dotIndex = newText.firstIndex(of: ".") {
                numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
            } else {
                numberOfDecimalDigits = 0
            }
            
//            return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
            return numberOfDots <= 1 && numberOfDecimalDigits <= 2
        }
    }
    
    static func restrictNumbersTo(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, maxLength: Int) -> Bool {
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}
