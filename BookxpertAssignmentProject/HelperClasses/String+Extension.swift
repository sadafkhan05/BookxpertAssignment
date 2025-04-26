//
//  String+Extension.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import Foundation

extension String {
    
    /// Get String from anyObject, returns " " if nil
    /// - Parameter value: AnyObject
    /// - Returns: String
    static func getString(_ value: Any?) -> String {
        guard let strMessage = value as? String else {
            guard let doubleValue = value as? Double else {
                guard let intValue = value as? Int else {
                    guard let int64Value = value as? Int64 else { return "" }
                    return String(int64Value)
                }
                return String(intValue)
            }
            
            let formatter                     = NumberFormatter()
            formatter.minimumFractionDigits   = 0
            formatter.maximumFractionDigits   = 2
            formatter.minimumIntegerDigits    = 1
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else {
                return ""
            }
            return formattedNumber
        }
        return strMessage.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
