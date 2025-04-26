//
//  TextField+Extension.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import UIKit

class BindableTextField: UITextField {
    
    var currentText: (String) -> () = { _ in }
    
    func bind(callback: @escaping (String) -> ()) {
        self.currentText = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.currentText(String.getString(textField.text))
    }
}
