//
//  BaseViewModel.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import Foundation

class BaseViewModel {
    enum LoaderEvent {
        case loading
        case stopLoading
        case dataLoaded(String?)
        case ErrorLoading(String)
    }
    
    public var brokenRules: [BrokenRule] = [BrokenRule]()
    
    public func getPrintableErrors() -> String {
        var error = ""
        brokenRules.forEach { rule in
            error += "\(rule.message)"
            error += "\n"
        }
        return error.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct BrokenRule {
    var propertyName: String
    var message: String
}
