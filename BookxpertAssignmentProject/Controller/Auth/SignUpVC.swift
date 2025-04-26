//
//  SignInVC.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {

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
    @IBOutlet weak var signUpBtnReff: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    
    var viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpBtnTap(_ sender: Any) {
       if self.viewModel.isValid {
            signUpVC()
       } else {
           self.showAlert(msg: self.viewModel.getPrintableErrors())
       }
    }
    
    @IBAction func logInBtnTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let picker = AssetPickerController(with: [.ImageLibrary, .ImageCamera])
        picker.initializeAssetPickerOn(controller: self, imageCompletion:  { image in
            self.userImage.image = image
        })
        
    }
    
}

// MARK: - Register User in Firebase
extension SignUpVC {

    func signUpVC() {
        if let email = emailTxtField.text, let  password = passwordTxtField.text {
            CommonUtils.showHud(show: true)
            
            Auth.auth().createUser(withEmail: email, password: password) { Auth, error in
                CommonUtils.showHud(show: false)
                if let error = error {
                    self.showAlert(msg: error.localizedDescription)
                } else {
                    CoreDataManager.shared.saveData(entity: .userEntity, dataModel: .init(id: nil,
                                                                                          name: nil,
                                                                                          email: email))
                    //Redirect to home
                    let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
        }
    }
}
