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
    
    private var viewModel = HomeViewModal()
    private var homeDataArr = [HomeDataModel]()
    
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
        
        tableView.separatorStyle = .singleLine
        
        getHomeData()
    }
}

//MARK: - TABLE VIEW DATA SOURCE & DELEGATE METHOD
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configureCell(data: self.homeDataArr[indexPath.row])
        cell.deleteClouser = {
            self.showAlertTwoButton(message: AlertConstant.sureToDelete.value(),
                                    continueText: AlertConstant.Continue.value(),
                                    cancelText: AlertConstant.Cancel.value()) { isContinue in
                if isContinue {
                    self.homeDataArr.remove(at: indexPath.row)
                    self.tableView.reloadData()
                    /// Also remove from core data.
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pdfView = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewerVC") as! PDFViewerVC
        pdfView.pdfUrl = StringConstant.pdfUrl
        self.navigationController?.pushViewController(pdfView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

//MARK: - Fetch Data from API
extension HomeVC {
    
    func getHomeData() {
        viewModel.performRequest(with: NetworkManager.apiUrl) { homeDataResult in
            switch homeDataResult {
            case .success(let dataModel):
                self.homeDataArr = dataModel
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                /// First Delete Existing the data from Entity and re-write it.
                for item in dataModel {
                    CoreDataManager.shared.saveData(entity: .homeEntity, dataModel: .init(id: item.id, 
                                                                                          name: item.name,
                                                                                          email: nil))
                }
                
            case .failure(let error):
                print("THE ERROR =>", error.localizedDescription)
                self.showAlert(msg: error.localizedDescription)
            }
        }
    }
    
    func logOutUser() {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signoutError as NSError {
            self.showAlert(msg: signoutError.localizedDescription)
        }
    }
}
