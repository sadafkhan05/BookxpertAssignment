//
//  StringConstant.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import Foundation

struct StringConstant {
    static let pdfUrl = "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf"
}

enum AlertConstant: String {
    case noInternet                 = "no Internet Connection"
    case noStatusCode               = "no Status Code Found"
    case noResponse                 = "no Response Data"
    case noDataFound                = "no Data Found"
    case unableToDecode             = "unable To Decode Data"
    case wentWrong                  = "something Went Wrong"
    case decodingError              = "Failed to decode response"
    case setTokenFatalErr           = "Set Token ExpireCode"
    case sessionExpired             = "session Expired"
    
    case validEmailReq              = "Please enter valid Email"
    case emptyPassword              = "Please enter your password"
    case minimumPassword            = "Password should be greater than 6 digits"
    
    case invalidPdfUrl              = "Invalid pdf URL"
    case noPdfFound                 = "No pdf found"
    
    
    case sureToDelete               = "Are you sure? You want to delete this item"
    case Continue                   = "Continue"
    case Cancel                     = "Cancel"
    
    func value() -> String {
        return self.rawValue
    }
}
