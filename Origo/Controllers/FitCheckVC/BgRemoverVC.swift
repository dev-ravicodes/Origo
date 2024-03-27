//
//  BgRemoverVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 13/03/24.
//

import UIKit
import PhotoRoomKit
import CropViewController
import DZNEmptyDataSet

protocol CropImage:AnyObject {
    func updatePhoto(_ selectedImg: UIImage, _ selectedButton:UIButton)
}
protocol ImageCellDelegate: AnyObject {
    func cropButtonTapped(at indexPath: IndexPath)
}

struct ImageItems{
    var originalImage = UIImage()
    var filterImage: UIImage = UIImage()
}

class BgRemoverVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var outfitCollectionView: UICollectionView! {
        didSet {
            outfitCollectionView.registerNib(OutfitCollectionCVC.self)
            outfitCollectionView.emptyDataSetSource = self
        }
    }
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var pageControll: UIPageControl!
    
    
    //MARK: - Variables
    var imgs = [UIImage]()
    var arrImgs = [ImageItems]()
    weak var cropDelegate: CropImage?
    var cropPreset : TOCropViewControllerAspectRatioPreset?
    var selectedButton : UIButton?
    var editProfileViewModel = EditProfileVM()
    var viewModelUploadImage = UploadImageVM()
    var viewModelAddOutfitVM = AddOutfitVM()
    
    private var currentPage: IndexPath = IndexPath(item: 0, section: 1)
    
    deinit {
        selectedButton = nil
        cropDelegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrImgs = imgs.compactMap{ImageItems(originalImage: $0,filterImage: $0)}
        self.removeBackground(self.arrImgs[self.currentPage.item].originalImage)
    }
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configUI()
        
    }
    
    private func configUI() {
        pageControll.numberOfPages = arrImgs.count
        pageControll.currentPage = currentPage.item
        userNameLbl.text = AppCache.shared.currentUser?.user.userName
    }
    
    
    //MARK: - Convenience
    
    func prepareRequestModel() {
        self.imgs = self.arrImgs.compactMap{$0.filterImage}
        viewModelUploadImage.requestModelArr.arrImages = self.imgs
        viewModelUploadImage.requestModelArr.url = "uploads"
        self.uploadLineImages()
    }
    //    func removeBackgroundd(_ originalImage: UIImage) {
    //        Task {
    //            let localImgs = imgs // Obtain a local copy
    //            let backgroundRemoved = try? await removeBackground(of: originalImage)
    //            imgs[currentPage.item] = backgroundRemoved ?? UIImage(named: "ic_OverlayImg")!
    //            self.outfitCollectionView.reloadData()
    //        }
    //    }
    
    
    func removeBackground(_ originalImage: UIImage) {
        let controller = PhotoRoomViewController(image: originalImage, apiKey: AppConstants.photoRoomAPIKey) { [weak self] image in
            self?.onImageEdited(image)
        }
        present(controller, animated: true)
    }
    
    
    func onImageEdited(_ editedImage: UIImage) {
        // Handle your segmented image
        if let currentLastIndex = self.arrImgs.indices.last{
            self.arrImgs[currentLastIndex].originalImage = editedImage
        }
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
    
    @IBAction func backAction(_ sender: UIButton) {
        self.popVC()
    }
    
    @IBAction func bgRemoverAction(_ sender: UIButton) {
       
    }
    
    @IBAction func effectsAction(_ sender: UIButton) {
        if arrImgs.count > 0 {
            //            guard let currentPage = currentPage else {}
            let randomInt = Int.random(in: 0..<8)
            if randomInt == 0 {
                //          imgs[currentPage.item] = imgs[currentPage.item].addFilter(filter: .Chrome)
                arrImgs[currentPage.item].filterImage = arrImgs[currentPage.item].originalImage.addFilter(filter: .Chrome)
                outfitCollectionView.reloadData()
            }
            else if randomInt == 1 {
                arrImgs[currentPage.item].filterImage = arrImgs[currentPage.item].originalImage.addFilter(filter: .Fade)
                outfitCollectionView.reloadData()
            }
            else if randomInt == 2 {
                arrImgs[currentPage.item].filterImage = arrImgs[currentPage.item].originalImage.addFilter(filter: .Instant)
                outfitCollectionView.reloadData()
            }  else if randomInt == 3 {
                arrImgs[currentPage.item].filterImage = arrImgs[currentPage.item].originalImage.addFilter(filter: .Mono)
                outfitCollectionView.reloadData()
            }
            else if randomInt == 4 {
                arrImgs[currentPage.item].filterImage = arrImgs[currentPage.item].originalImage.addFilter(filter: .Noir)
                outfitCollectionView.reloadData()
            }
            else if randomInt == 5 {
                arrImgs[currentPage.item].filterImage = arrImgs[currentPage.item].originalImage.addFilter(filter: .Process)
                outfitCollectionView.reloadData()
            }  else if randomInt == 6 {
                arrImgs[currentPage.item].filterImage = arrImgs[currentPage.item].originalImage.addFilter(filter: .Tonal)
                outfitCollectionView.reloadData()
            }
            else if randomInt == 7 {
                arrImgs[currentPage.item].filterImage = arrImgs[currentPage.item].originalImage.addFilter(filter: .Transfer)
                outfitCollectionView.reloadData()
            }
        }
        
    }
    @IBAction func cropAction(_ sender: UIButton) {
        cropDelegate = self
        
        self.presentCropViewController(arrImgs[currentPage.item].filterImage)
    }
    
    @IBAction func addPicAction(_ sender: UIButton) {
        
        editProfileViewModel.objCameraGalleryClass.cameraDelegate = self
        editProfileViewModel.objCameraGalleryClass.customImagePicker(self, sender: sender)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        self.prepareRequestModel()
    }
    
    func navigateToConfirmOutfitGuideLinesVC() {
        if !AppCache.shared.showGuidelines {
            let nextVC = ScreenManager.getController(storyboard: .home, controller: ConfirmOutfitGuideLines.self)
            nextVC.onConfirm = { [weak self] in
                guard let self else {return}
                let nextVC = ScreenManager.getController(storyboard: .home, controller: ChooseSeasonVC.self)
                nextVC.viewModelAddOutfitVM = self.viewModelAddOutfitVM
                navigationController?.pushViewController(nextVC, animated: true)
            }
            nextVC.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(nextVC, animated: true)
        } else {
            let nextVC = ScreenManager.getController(storyboard: .home, controller: ChooseSeasonVC.self)
            nextVC.viewModelAddOutfitVM = self.viewModelAddOutfitVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}


//MARK: - CameraGalleryDelegate Method
extension BgRemoverVC: CameraGalleryDelegate {
    func updatePhotoFromGallery(_ selectedImg: UIImage, _ selectedButton: UIButton) {
        DispatchQueue.main.async {
            self.arrImgs.append(ImageItems(originalImage: selectedImg, filterImage: selectedImg))
            self.removeBackground(selectedImg)
            self.outfitCollectionView.reloadData()
            self.configUI()
        }
    }
}


// MARK: - TOCropViewController's Delegate Methods
extension BgRemoverVC: TOCropViewControllerDelegate {
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
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true) {
            self.cropDelegate?.updatePhoto(image, self.selectedButton ?? UIButton())
        }
    }
    
}


//MARK: - CropImageDelegate Method
extension BgRemoverVC: CropImage {
    func updatePhoto(_ selectedImg: UIImage, _ selectedButton: UIButton) {
        
        DispatchQueue.main.async {
            self.arrImgs[self.currentPage.item].filterImage = selectedImg
            self.arrImgs[self.currentPage.item].originalImage = selectedImg
            self.outfitCollectionView.reloadData()
        }
    }
    
}


extension BgRemoverVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrImgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: OutfitCollectionCVC.self, for: indexPath)
        cell.onRemove = { [weak self] in
            guard let self else {return}
            
            arrImgs.remove(at: indexPath.item)
            configUI()
            outfitCollectionView.reloadData()
        }
        cell.configUI(img: arrImgs[indexPath.row].filterImage)
        cell.removeBtn.isHidden = false
        if arrImgs.count == 1{
            cell.removeBtn.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: outfitCollectionView.frame.width, height: outfitCollectionView.frame.height)
    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        let visibleIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    //        currentPage?.item = visibleIndex
    //        self.configUI()
    //    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: outfitCollectionView.contentOffset, size: outfitCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let visibleIndexPath = outfitCollectionView.indexPathForItem(at: visiblePoint) {
            currentPage = visibleIndexPath
            print(currentPage)
            self.configUI()
        }
    }
    
}


// MARK: - DZNEmptyDataSetSource Methods
extension BgRemoverVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "No data added"
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.urbanistBold(ofSize: 20.0),
            NSAttributedString.Key.foregroundColor: UIColor.buttonBG
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = ""
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.urbanistBold(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor: UIColor.buttonBG, NSAttributedString.Key.paragraphStyle: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -10    //move label up or down
    }
    
}

extension BgRemoverVC {
    func uploadLineImages() {
        CustomLoader.shared.show()
        self.viewModelUploadImage.uploadArrImage { (result) in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                let finalURLs = self.viewModelUploadImage.responseModelArr?.data ?? [String]()
                self.viewModelAddOutfitVM.requestModel.outfitImages = finalURLs
                self.navigateToConfirmOutfitGuideLinesVC()
            case.failure(let error):
                CustomLoader.shared.hide()
                self.showAlert(message: error.message)
            }
        }
        
    }
    
}
