//
//  Gradient Button.swift
//  Gutter
//
//  Created by yapapp on 12/12/22.
//

import UIKit
import Photos
import CropViewController
import PhotosUI

protocol CameraGalleryDelegate:AnyObject {
    func updatePhotoFromGallery(_ selectedImg: UIImage, _ selectedButton:UIButton)
}

class CameraGalleryClass:NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK:- Properties
    weak var cameraDelegate: CameraGalleryDelegate?
    var selectedButton : UIButton?
    var cropPreset : TOCropViewControllerAspectRatioPreset?
    
    deinit {
        selectedButton = nil
        cameraDelegate = nil
    }
    
    func openOnlyCamera(_ controller: UIViewController) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: nil, message: .deviceHasNoCamera, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: .ok, style: .default, handler: { (alert: UIAlertAction!) in
            })
            
            alertController.addAction(okAction)
            controller.present(alertController, animated: true, completion: nil)
        } else {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            debugPrint(authStatus)
            switch authStatus {
            case .authorized:
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                controller.present(imagePicker, animated: true, completion: nil)
            case .denied:
                self.alertToEncourageCameraAccessInitially(controller)
            case .notDetermined:
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                controller.present(imagePicker, animated: true, completion: nil)
            default:
                self.alertToEncourageCameraAccessInitially(controller)
            }
        }
    }
    
    func openOnlyGallery(_ controller: UIViewController) {
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                            self.showGallery(.savedPhotosAlbum)
                        }
                    }
                } else {
                    self.alertToEncourageGalleryAccessInitially(controller)
                }
            })
        } else {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                            self.showGallery(.savedPhotosAlbum)
                        }
                    }
                } else {
                    self.alertToEncourageGalleryAccessInitially(controller)
                }
            })
        }
    }
    
    func customImagePicker(_ controller: UIViewController, sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: .chooseAnyOption, preferredStyle: .actionSheet)
        
        //Open Camera
        actionSheet.addAction(UIAlertAction(title: .camera, style: .default, handler: {
            action in
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: nil, message: .deviceHasNoCamera, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: .ok, style: .default, handler: { (alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                controller.present(alertController, animated: true, completion: nil)
            } else {
                self.openOnlyCamera(controller)
            }
        }))
        
        //Open Photo/Gallery
        actionSheet.addAction(UIAlertAction(title: .gallery, style: .default, handler: {
            action in
            //Photos
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized {
                        DispatchQueue.main.async {
                            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                                self.showGallery(.savedPhotosAlbum)
                            }
                        }
                    } else {
                        self.alertToEncourageGalleryAccessInitially(controller)
                    }
                })
            } else {
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized {
                        DispatchQueue.main.async {
                            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                                self.showGallery(.savedPhotosAlbum)
                            }
                        }
                    } else {
                        self.alertToEncourageGalleryAccessInitially(controller)
                    }
                })
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: .cancel, style: .cancel, handler: {
            action in
            controller.dismiss(animated: true, completion: nil)
        }))
        DispatchQueue.main.async {
            actionSheet.popoverPresentationController?.sourceView = sender.superview
            actionSheet.popoverPresentationController?.sourceRect = sender.frame
            controller.present(actionSheet, animated: true, completion: nil)
        }
    }
    func openPhotoOrGallery(_ controller: UIViewController, sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let cameraMediaType = AVMediaType.video
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
            switch cameraAuthorizationStatus {
            case .denied:
                debugPrint("cameraAuthorizationStatus=denied")
                break
            case .authorized:
                self.showGallery(sourceType)
            case .restricted:
                debugPrint("cameraAuthorizationStatus=restricted")
                break
            case .notDetermined:
                debugPrint("cameraAuthorizationStatus=notDetermined")
                // Prompting user for the permission to use the camera.
                AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                    DispatchQueue.main.sync {
                        if granted {
                            self.showGallery(sourceType)
                        }
                    }
                }
            default:
                break
            }
        }
    }
    
    func showGallery(_ sourceType: UIImagePickerController.SourceType) {
        if #available(iOS 14, *) {
            var config = PHPickerConfiguration()
            config.filter = .images
            config.selectionLimit = 1
            config.preferredAssetRepresentationMode = .current
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
//            picker.modalPresentationStyle = .overFullScreen
            DispatchQueue.main.async {
                UIApplication.topViewController()?.present(picker, animated: true)
            }
        } else {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = sourceType
                DispatchQueue.main.async {
                    UIApplication.topViewController()?.present(imagePicker, animated: true)
                }
            } else {
                let alert  = UIAlertController(title: .warning, message: .youDoNotHvPermission, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: .ok, style: .default, handler: nil))
                DispatchQueue.main.async {
                    UIApplication.topViewController()?.present(alert, animated: true)
                }
            }
        }
    }
    
    func alertToEncourageGalleryAccessInitially(_ controller: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: .important,
                message: .galleryRequiredAccess,
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(title: .cancel, style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: .gallery, style: .destructive, handler: { (alert) -> Void in
                self.useNewOpenUrl(UIApplication.openSettingsURLString)
            }))
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertToEncourageCameraAccessInitially(_ controller: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: .important,
                message: .cameraRequiredAccess,
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(title: .cancel, style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: .allowCamera, style: .destructive, handler: { (alert) -> Void in
                self.useNewOpenUrl(UIApplication.openSettingsURLString)
            }))
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertPromptToAllowCameraAccessViaSetting(_ controller: UIViewController) {
        
        let alert = UIAlertController(
            title: .important,
            message: .cameraRequiredAccess,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: .dismiss, style: .cancel) { alert in
            if AVCaptureDevice.devices(for: AVMediaType.video).count > 0 {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    DispatchQueue.main.async() {
                        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                        switch authStatus {
                        case .authorized:
                            self.openPhotoOrGallery(controller, sourceType: .camera)
                        default:
                            controller.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        })
        controller.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Open Application with Predefine Method
    func useNewOpenUrl(_ urlStr: String) {
        let myUrl = urlStr
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        // or outside scope use this
        guard let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //MARK:- Image Picker Controller Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //guard let fileUrl = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        if let chosenImage = info[.originalImage] as? UIImage {
            debugPrint(chosenImage)
            picker.dismiss(animated: true) {
                self.presentCropViewController(chosenImage)
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TOCropViewController's Delegate Methods
    func presentCropViewController(_ img: UIImage) {
        let cropViewController = TOCropViewController(image: img)
//        if let preset = cropPreset{
//        cropViewController.aspectRatioPrese
            cropViewController.customAspectRatio = CGSize(width: 9, height: 16)
            cropViewController.aspectRatioLockEnabled = true
            cropViewController.aspectRatioPickerButtonHidden = true
//        }
        cropViewController.delegate = self
//        cropViewController.modalPresentationStyle = .overFullScreen
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(cropViewController, animated: true)
        }
    }
}

extension CameraGalleryClass: TOCropViewControllerDelegate {
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true) {
            self.cameraDelegate?.updatePhotoFromGallery(image, self.selectedButton ?? UIButton())
        }
    }
}

//MARK:- DELEGATE METHODS FOR PHPICKERVIEW CONTROLLER
extension CameraGalleryClass: PHPickerViewControllerDelegate {
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if results.isEmpty {
            DispatchQueue.main.async {
                picker.dismiss(animated: true)
            }
            return
        }
        guard let result = results.first else { return }

//        let jpeg = UTType.image.identifier
        
        let prov = result.itemProvider
        let identifier = prov.registeredTypeIdentifiers.first ?? ""
        prov.loadObject(ofClass: UIImage.self) { (image, error) in
            DispatchQueue.main.async {
                if let image = image as? UIImage {
                    picker.dismiss(animated: true) {
                        self.presentCropViewController(image)
                    }
                } else {
                    print("Error loading image: \(String(describing: error))")
                    picker.dismiss(animated: true)
                }
            }
        }
    }
}

struct ImageCompressor {
    
    static func compress(image: UIImage, maxByte: Int,
                             completion: @escaping (UIImage?) -> ()) {
            DispatchQueue.global(qos: .userInitiated).async {
                guard let currentImageData = image.jpegData(compressionQuality: 1.0)else {
                    return DispatchQueue.main.async { completion(nil) }
                }
                
                var iterationImage: UIImage? = image
                var iterationImageSize = currentImageData.count
                var iterationCompression: CGFloat = 1.0
                
                while iterationImageSize > maxByte && iterationCompression > 0.01 {
                    let percentageDecrease = getPercentageToDecreaseTo(forDataCount: iterationImageSize)
                    iterationCompression -= percentageDecrease
                    
                    guard let resizedImage = resizeImage(image, compression: iterationCompression),
                          let newImageData = resizedImage.jpegData(compressionQuality: 1.0)else {
                        return DispatchQueue.main.async { completion(nil) }
                    }
                    
                    iterationImage = resizedImage
                    iterationImageSize = newImageData.count
                }
                
                DispatchQueue.main.async { completion(iterationImage) }
            }
        }
        
        private static func resizeImage(_ image: UIImage, compression: CGFloat) -> UIImage? {
            let canvasSize = CGSize(width: image.size.width * compression,
                                    height: image.size.height * compression)
            
            UIGraphicsBeginImageContextWithOptions(canvasSize, false, image.scale)
            defer { UIGraphicsEndImageContext() }
            image.draw(in: CGRect(origin: .zero, size: canvasSize))
            
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        
        private static func getPercentageToDecreaseTo(forDataCount dataCount: Int) -> CGFloat {
            switch dataCount {
            case 0..<5000000: return 0.03
            case 5000000..<10000000: return 0.1
            default: return 0.2
            }
        }
    
//    static func compress(image: UIImage, maxByte: Int,
//                         completion: @escaping (UIImage?) -> ()) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            guard let currentImageSize = image.jpegData(compressionQuality: 1.0)?.count else {
//                return completion(nil)
//            }
//
//            var iterationImage: UIImage? = image
//            var iterationImageSize = currentImageSize
//            var iterationCompression: CGFloat = 1.0
//
//            while iterationImageSize > maxByte && iterationCompression > 0.01 {
//                let percentageDecrease = getPercentageToDecreaseTo(forDataCount: iterationImageSize)
//
//                let canvasSize = CGSize(width: image.size.width * iterationCompression,
//                                        height: image.size.height * iterationCompression)
//                UIGraphicsBeginImageContextWithOptions(canvasSize, false, image.scale)
//                defer { UIGraphicsEndImageContext() }
//                image.draw(in: CGRect(origin: .zero, size: canvasSize))
//                iterationImage = UIGraphicsGetImageFromCurrentImageContext()
//
//                guard let newImageSize = iterationImage?.jpegData(compressionQuality: 1.0)?.count else {
//                    return completion(nil)
//                }
//                iterationImageSize = newImageSize
//                iterationCompression -= percentageDecrease
//            }
//            completion(iterationImage)
//        }
//    }
//
//    private static func getPercentageToDecreaseTo(forDataCount dataCount: Int) -> CGFloat {
//        switch dataCount {
//        case 0..<5000000: return 0.03
//        case 5000000..<10000000: return 0.1
//        default: return 0.2
//        }
//    }

}
