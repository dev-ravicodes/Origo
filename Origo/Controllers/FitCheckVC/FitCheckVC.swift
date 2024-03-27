//
//  FitCheckVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 11/03/24.
//

import UIKit

class FitCheckVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var uploadOutfitBtn: UIButton!
    
    
    //MARK: - Variables
    var editProfileViewModel = EditProfileVM()
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    
    //MARK: - Convenience
    private func configUI() {
        uploadOutfitBtn.titleLabel?.textAlignment = .center
        uploadOutfitBtn.titleLabel?.numberOfLines = 0
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func profileAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .profile, controller: ProfileVC.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func settingAction(_ sender: UIButton) {
        let vc = ScreenManager.getController(storyboard: .profile, controller: ProfileSettingsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func showInfoAction(_ sender: UIButton) {
        let vc = ScreenManager.getController(storyboard: .authentication, controller: FitCheckInfoVC.self)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func uploadImageAction(_ sender: UIButton) {
        editProfileViewModel.objCameraGalleryClass.cameraDelegate = self
        editProfileViewModel.objCameraGalleryClass.customImagePicker(self, sender: sender)
    }
    
}


//MARK: - CameraGalleryDelegate Method
extension FitCheckVC: CameraGalleryDelegate {
    func updatePhotoFromGallery(_ selectedImg: UIImage, _ selectedButton: UIButton) {
        DispatchQueue.main.async {
            let nextVc = ScreenManager.getController(storyboard: .home, controller: BgRemoverVC.self)
            nextVc.imgs.append(selectedImg)
            self.navigationController?.pushViewController(nextVc, animated: true)
        }
    }
}


//MARK: - UIPopoverPresentationControllerDelegate Method
extension FitCheckVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for: UIPresentationController) -> UIModalPresentationStyle {
        //return UIModalPresentationStyle.fullScreen
        return UIModalPresentationStyle.none
    }
    
}
