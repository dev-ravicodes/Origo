//
//  AlertProtocol.swift
//  JiuJitsu
//
//  Created by iTechnolabs - 7 on 03/01/24.
//

import UIKit

protocol AlertProtocol {
}

extension AlertProtocol where Self: UIViewController {
    
    func showAlertWithText(_ message:String, buttonTitle: String = LocalizedStringEnum.ok.localized, completion: ((UIAlertAction) -> ())? = nil) {
        //        let alert = UIAlertController(title: LocalizedStringEnum.appName.localized, message: message, preferredStyle: .alert)
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: buttonTitle, style: .default, handler: completion)
        alert.addAction(firstAction)
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTwoButton(message: String, firstButtonTitle: String, secondButtonTitle: String, firstButtonCompletion: @escaping (UIAlertAction) -> (), secondButtonCompletion: @escaping (UIAlertAction) -> ()) {
        
        //        let alert = UIAlertController(title: LocalizedStringEnum.appName.localized, message: message, preferredStyle: .alert)
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: firstButtonTitle, style: .default, handler: firstButtonCompletion)
        alert.addAction(firstAction)
        
        let secondAction = UIAlertAction(title: secondButtonTitle, style: .default, handler: secondButtonCompletion)
        alert.addAction(secondAction)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTextField(message: String, placeholder: String, completion: @escaping (String?) -> (), keyboardType: UIKeyboardType, cancelHandler: @escaping (UIAlertAction) -> ()) {
        //        let alert = UIAlertController(title: LocalizedStringEnum.appName.localized, message: message, preferredStyle: .alert)
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: LocalizedStringEnum.cancel.localized, style: .default, handler: cancelHandler)
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: LocalizedStringEnum.ok.localized, style: .default, handler: { action in
            let textField = alert.textFields?.first
            completion(textField?.text)
        })
        alert.addAction(okAction)
        
        alert.addTextField { (textField) in
            textField.placeholder = placeholder
            textField.keyboardType = keyboardType
        }
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}

