//
//  UIViewController+Extension.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import UIKit

typealias VoidClosure = () -> Void

extension UIViewController {
    
    public func showAlert(msg:String, completion:(()->())? = nil) {
        let alert = UIAlertController(title: Bundle.main.ApplicationName ?? "", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        self.present(alert, animated: true)
    }
    
    func showAlertTwoButton(title: String = Bundle.main.ApplicationName ?? "",
                            message:String,
                            continueText: String,
                            continueTextStyle: UIAlertAction.Style = .default,
                            cancelText: String,
                            cancelTextStyle: UIAlertAction.Style = .cancel,
                            callback: @escaping (_ bool: Bool)->Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let rightAction = UIAlertAction(title: continueText, style: continueTextStyle) {
            UIAlertAction in
            callback(true)
            NSLog("Continue Pressed")
        }
        
        let leftAction = UIAlertAction(title: cancelText, style: cancelTextStyle) {
            UIAlertAction in
            callback(false)
            NSLog("Cancel Pressed")
        }
        
        
        // Add the actions
        alert.addAction(leftAction)
        alert.addAction(rightAction)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //===============================================================//
    func showAlertOneButton(title: String = Bundle.main.ApplicationName ?? "",
                            message:String,
                            continueText: String,
                            continueTextStyle: UIAlertAction.Style = .default,
                            callback: @escaping (_ bool: Bool)->Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let rightAction = UIAlertAction(title: continueText, style: continueTextStyle) {
            UIAlertAction in
            callback(true)
            NSLog("Continue Pressed")
        }
        
        // Add the actions
        alert.addAction(rightAction)
        
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Bundle Extension
extension Bundle {
    ///Application Name
    var ApplicationName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }    
}
