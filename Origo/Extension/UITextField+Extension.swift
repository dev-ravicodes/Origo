//
//  ViewController+Extension.swift
//  Hammer Parking
//
//  Created by yapapp on 10/20/22.
//

import UIKit

extension UITextField{
    
    func configLblColor(str:String,view:UIView){
        if str.isEmptyWithTrimmedSpace{
            //empty
            view.layer.borderWidth = 0
        }else{
            view.backgroundColor = .white
            view.layer.borderWidth = 1
        }
    }
    
    func addInputViewDatePicker(target: Any,isMinDate:Bool?=true, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: App.locale) //changes date picker date format
        if isMinDate == true{
            datePicker.minimumDate = Date()
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        self.inputView = datePicker
        tintColor = .clear
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
}

extension Dictionary{
    func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}
protocol MyTextFieldDelegate: AnyObject {
    func textFieldDidDelete()
}

class MyTextField: UITextField {

    weak var myDelegate: MyTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete()
    }

}
