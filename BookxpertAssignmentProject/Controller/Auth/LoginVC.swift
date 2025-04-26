//
//  LoginVC.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxtField: BindableTextField! {
        didSet {
            emailTxtField.bind { self.viewModel.email = $0 }
        }
    }
    @IBOutlet weak var passwordTxtField: BindableTextField! {
        didSet {
            passwordTxtField.bind { self.viewModel.password = $0 }
        }
    }
    @IBOutlet weak var loginBtnReff: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginBtnTap(_ sender: Any) {
        if self.viewModel.isValid {
            loginUser()
        } else {
            self.showAlert(msg: self.viewModel.getPrintableErrors())
        }
    }
    
    @IBAction func signUpBtnTap(_ sender: Any) {
        let signUpVC = self.storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
}

// MARK: - Login User from Firebase
extension LoginVC {
    
    func loginUser() {
        if let email = emailTxtField.text, let password = passwordTxtField.text {
            CommonUtils.showHud(show: true)
            
            Auth.auth().signIn(withEmail: email, password: password) { AuthData, error in
                CommonUtils.showHud(show: false)
                
                if let error = error {
                    self.showAlert(msg: error.localizedDescription)
                } else {
                    let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
        }
    }
}
