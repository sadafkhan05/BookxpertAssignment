//
//  AssetProfilePicker.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 26/04/25.
//

import UIKit
import Foundation
import MobileCoreServices
import UniformTypeIdentifiers

class AssetPickerController : NSObject {
    
    enum AssetType : Int {
        case ImageLibrary
        case ImageCamera
        case VideoLibrary
        case VideoCamera
        case PdfDocument
        
        func value() -> String {
            switch self {
            case .ImageLibrary: return "Photo Library"
            case .ImageCamera: return "Photo Camera"
            case .VideoLibrary: return "Video Library"
            case .VideoCamera: return "Video Camera"
            case .PdfDocument: return "Document"
            }
        }
    }
    
    typealias urlResult = (_ result:URL) -> Void
    typealias imageResult = (_ result:UIImage) -> Void
    
    public var urlCompletion:urlResult?
    public var imageCompletion:imageResult?
    
    private var selectedAssetType:[AssetType] = []
    private var presentingVc:UIViewController?
    
    public init(with type:[AssetType]) {
        guard type.count > 0 else {
            fatalError("Provide atleast one asset type")
        }
        self.selectedAssetType = type
    }
    
    public func initializeAssetPickerOn(controller:UIViewController,
                                        urlCompletion:urlResult? = nil,
                                        imageCompletion:imageResult? = nil) {
        let list = self.selectedAssetType.map({$0.value()})
        self.presentingVc = controller
        
        self.showActionSheet(withOptions: list, controller: controller) { selectedIndex in
            let type = self.selectedAssetType[selectedIndex]
            switch type {
            case .ImageLibrary:
                self.initializeImageLibrary()
            case .ImageCamera:
                self.initializeImageCamera()
            case .VideoLibrary:
                self.initializeVideoLibrary()
            case .VideoCamera:
                self.initializeVideoCamera()
            case .PdfDocument:
                self.initializeDocument()
            }
        }
        
        self.urlCompletion = urlCompletion
        self.imageCompletion = imageCompletion
    }
    
    private func showActionSheet(withOptions options: [String],
                                 controller:UIViewController,
                                 handler:@escaping (_ selectedIndex: Int) -> Void) {
        let alert = UIAlertController(title: Bundle.main.ApplicationName ?? "", message: "Choose From Below Option", preferredStyle: .actionSheet)
        
        for strAction in options {
            let anyAction =  UIAlertAction(title: strAction, style: .default){ (action) -> Void in
                return handler(options.firstIndex(of: strAction)!)
            }
            alert.addAction(anyAction)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        controller.present(alert, animated: true)
    }
    
    private func initializeImageLibrary() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [UTType.image.identifier as String]
        picker.delegate = self
        self.presentingVc?.present(picker, animated: true)
    }
    
    private func initializeImageCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = .camera
            picker.mediaTypes = [UTType.image.identifier as String]
            picker.cameraCaptureMode = .photo
            self.presentingVc?.present(picker, animated: true)
        } else {
            UIApplication.shared.topViewController()?.showAlert(msg: "Camera No Available Error")
        }
    }
    
    private func initializeVideoLibrary() {
        let picker = UIImagePickerController()
        picker.videoMaximumDuration = 60
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [UTType.movie.identifier as String]
        picker.delegate = self
        self.presentingVc?.present(picker, animated: true)
    }
    
    private func initializeVideoCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.videoMaximumDuration = 60
            picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = .camera
            picker.mediaTypes = [UTType.movie.identifier as String]
            picker.cameraCaptureMode = .video
            self.presentingVc?.present(picker, animated: true)
        } else {
            UIApplication.shared.topViewController()?.showAlert(msg: "Camera No Available Error")
        }
    }
}

extension AssetPickerController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey  : Any]) {
        
        if picker.mediaTypes == ["public.movie"]{
            guard let url = info[.mediaURL] as? URL else { return }
            self.urlCompletion?(url)
        } else{
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
            self.imageCompletion?(image)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension AssetPickerController : UIDocumentPickerDelegate {
    private func initializeDocument() {
        let doc = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        doc.delegate = self
        self.presentingVc?.present(doc, animated: true)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            defer { url.stopAccessingSecurityScopedResource() }
            guard url.startAccessingSecurityScopedResource() else {
                return
            }
            self.urlCompletion?(url)
        }
    }
}
