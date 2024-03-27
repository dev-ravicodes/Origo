//
//  UIViewController+Extension.swift
//  Whetness
//
//  Created by Kamaljeet Punia on 23/03/21.
//  Copyright © 2021 Kamaljeet Punia. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

extension UIViewController {
    
    func checkIfItemExist<T, V: Equatable>(in array: [T], propertyKeyPath: KeyPath<T, V>, withValue value: V)->Bool {
        let exists = array.contains { element in
            return element[keyPath: propertyKeyPath] == value
        }
        if !exists {
            return false
        }else{
            return true
        }
    }
    
    
    func enableIQKeyboard(){
        IQKeyboardManager.shared.enable = true
    }
    
    func disableIQKeyboard(){
        IQKeyboardManager.shared.enable = false
    }
    
    func popVC(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message:String? = nil)  {
        let alertController = UIAlertController(title: App.name, message: message ?? "", preferredStyle: .alert)
        let action = UIAlertAction(title: LocalizedStringEnum.ok.localized, style: .default, handler: nil)
        alertController.addAction(action)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showUpdateAlert(message:String? = nil, okCallback:@escaping () -> Void)  {
        
        let alertController = UIAlertController(title: App.name, message: message ?? "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Update", style: .default, handler: { (_ ) in
            okCallback()
        })
        alertController.addAction(action)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertWithCancel(message:String? = nil, okTitle:String?=LocalizedStringEnum.ok.localized, okCallback:@escaping () -> Void) {
        let alertController = UIAlertController(title: App.name, message: message ?? "", preferredStyle: .alert)
        let action = UIAlertAction(title: okTitle ?? "", style: .default, handler: { (_ ) in
            okCallback()
        })
        
        let cancel = UIAlertAction(title: LocalizedStringEnum.cancel.localized, style: .default, handler: nil)
        alertController.addAction(action)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithAction(title:String?=App.name,message: String, action1Title:String?=LocalizedStringEnum.ok.localized, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action1Title, style: .cancel, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTwoActions(alertTitle:String, message: String, action1Title:String, action1Style: UIAlertAction.Style ,action2Title: String ,completion1: ((UIAlertAction) -> Void)? = nil,completion2 :((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action1Title, style: action1Style, handler: completion1))
        alert.addAction(UIAlertAction(title: action2Title, style: .default, handler: completion2))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSheetWithTwoActions(alertTitle:String, message: String, action1Title:String, action1Style: UIAlertAction.Style ,action2Title: String ,completion1: ((UIAlertAction) -> Void)? = nil,completion2 :((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: action1Title, style: action1Style, handler: completion1))
        alert.addAction(UIAlertAction(title: action2Title, style: .cancel, handler: completion2))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlertWithKeyboard(title:String? = App.name,
                         subtitle:String? = nil,
                         actionTitle:String? = LocalizedStringEnum.add.localized,
                         cancelTitle:String? = LocalizedStringEnum.cancel.localized,
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: cancelHandler))
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func areEqualImages(img1: UIImage?, img2: UIImage?) -> Bool {

        guard let data1 = img1?.pngData() else { return false }
        guard let data2 = img2?.pngData() else { return false }

        let nsData1 = data1 as! NSData
//        let nsData2 = data2 as! NSData
        return nsData1.isEqual(to: data2)
    }
    
    func reloadPickerAndTxtField(pickerView:UIPickerView,txtField:UITextField){
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.reloadAllComponents()
        txtField.isUserInteractionEnabled = true
    }
    
}
