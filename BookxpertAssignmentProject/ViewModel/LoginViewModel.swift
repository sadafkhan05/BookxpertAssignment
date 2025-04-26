//
//  LoginViewModel.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import Foundation

final class LoginViewModel: BaseViewModel {
    
    //MARK: - Public Variables
    var email: String = ""
    var password: String = ""
    
    var isValid: Bool {
        brokenRules = [BrokenRule]()
        validate()
        return brokenRules.count == 0 ? true : false
    }
    
    override init() { }

    
    //MARK: - Private Methods
    private func validate() {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !email.trimmingCharacters(in: .whitespacesAndNewlines).isValidEmail(){
            brokenRules.append(.init(propertyName: "", message: AlertConstant.validEmailReq.value()))
        } else if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            brokenRules.append(.init(propertyName: "", message: AlertConstant.emptyPassword.value()))
        } else if password.trimmingCharacters(in: .whitespacesAndNewlines).count < 6 {
            brokenRules.append(.init(propertyName: "", message: AlertConstant.minimumPassword.value()))
        }
    }

}
