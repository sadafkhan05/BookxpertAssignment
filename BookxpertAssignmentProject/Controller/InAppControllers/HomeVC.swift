//
//  HomeVC.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
      
    }
    
    @IBAction func logoutTap(_ sender: Any) {
        logOutUser()
    }
    
   

}

//MARK: - SET UP TABLE VIEW
extension HomeVC {
    func initialSetUp() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
         tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - TABLE VIEW DATA SOURCE & DELEGATE METHOD
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
}

extension HomeVC {
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signoutError as NSError {
            self.showAlert(msg: signoutError.localizedDescription)
        }

    }
}
