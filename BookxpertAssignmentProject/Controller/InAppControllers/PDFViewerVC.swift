//
//  PDFViewerVC.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 25/04/25.
//

import UIKit
import WebKit

class PDFViewerVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var pdfUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPdf()
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Load PDF To WebView
extension PDFViewerVC {
    func loadPdf() {
        if let pdfUrl {
            guard let url: URL = URL(string: pdfUrl) else {
                self.showAlert(msg: AlertConstant.invalidPdfUrl.value())
                return
            }
            webView.load(URLRequest(url: url))
        } else {
            self.showAlert(msg: AlertConstant.noPdfFound.value())
        }
        
    }
}
