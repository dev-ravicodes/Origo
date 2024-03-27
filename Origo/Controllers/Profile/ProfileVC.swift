//
//  ProfileVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/02/24.
//

import UIKit
import DZNEmptyDataSet


enum EditImage {
    case avtarImage, profileImage
}

class ProfileVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.emptyDataSetSource = self
            self.collectionView.registerNib(MostLikedCVC.self)
        }
    }
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var nightsOutCollectionView: UICollectionView! {
        didSet {
            self.nightsOutCollectionView.emptyDataSetSource = self
            self.nightsOutCollectionView.registerNib(MostLikedCVC.self)
            self.nightsOutCollectionView.registerNib(MyRackCVC.self)
            self.nightsOutCollectionView.registerCollectionResuableView(SectionHeaderView.self, kind: "header")
            self.nightsOutCollectionView.collectionViewLayout = layout()
        }
    }
    @IBOutlet weak var avtarBgImg: UIImageView!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var createAHighlightView: UIView!
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var hangersView: UIView!
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var historicalRecordLbl: UILabel!
    @IBOutlet weak var topCreatorLbl: UILabel!
    @IBOutlet weak var infoTextView: UITextView! {
        didSet {
            infoTextView.delegate = self
        }
    }
    @IBOutlet weak var infoEditLbl: UILabel!
    @IBOutlet weak var seeAllOutfitBtn: UIButton!
    @IBOutlet weak var createHighLightBtn: UIButton!
    @IBOutlet weak var saveChangesBtn: UIButton!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    
    //MARK: - Variables
    var viewModel = ProfileVM()
    var editProfileViewModel = EditProfileVM()
    var uploadImageModel = UploadImageVM()
    var isEditAble = false
    var isEditingImage: EditImage = .avtarImage
    var updateHighLightsVM = HighLightsVM()
    
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configUI()
    }
    
    
    //MARK: - Convenience
    private func configUI() {
        self.hangersView.addBottomShadow()
        self.createAHighlightView.layer.shadowColor = UIColor.black.cgColor
        self.createAHighlightView.layer.shadowOpacity = 0.2
        self.createAHighlightView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.createAHighlightView.layer.shadowRadius = 2
        self.createAHighlightView.layer.masksToBounds = false
        self.createAHighlightView.layer.shouldRasterize = true
        self.createAHighlightView.layer.rasterizationScale = UIScreen.main.scale
        self.configLayout()
        self.getProfileApi()
    }
    
    private func reloadAndAdjustCollectionViewHeight() {
        self.nightsOutCollectionView.reloadData()
        self.view.layoutIfNeeded()
        let height = self.nightsOutCollectionView.collectionViewLayout.collectionViewContentSize.height
        self.collectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }
    
    private func configData() {
        self.nameTextFeild.text = viewModel.responseModel?.data.userProfile.userName
        let profileImage = viewModel.responseModel?.data.userProfile.profilePicture ?? ""
        if !profileImage.isBlank {
            self.userImgView.setImageWithKF(profileImage)
        }
        let avtarImage = viewModel.responseModel?.data.userProfile.avatar ?? ""
        if !avtarImage.isBlank {
            self.avtarBgImg.setImageWithKF(avtarImage)
        }
        let attributedString = NSMutableAttributedString(string: viewModel.responseModel?.data.hangerRecords ?? "")
        
        let pattern = #"\b(top)\b|\b\d+\b|[^\w\s]"#
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let matches = regex.matches(in: attributedString.string, range: NSRange(location: 0, length: attributedString.length))
            for match in matches {
                let range = match.range
                attributedString.addAttribute(.foregroundColor, value: UIColor.accountTypeBg, range: range)
                attributedString.addAttribute(.font, value: UIFont.urbanistBold(ofSize: 14), range: range)
            }
        } catch {
            print("Error creating regular expression: \(error)")
        }
        historicalRecordLbl.attributedText = attributedString
        if (viewModel.responseModel?.data.userProfile.aboutInfo ?? "").isBlank {
            self.infoTextView.text = "No Bio Added"
        } else {
            self.infoTextView.text = viewModel.responseModel?.data.userProfile.aboutInfo
        }
        collectionViewHeight.constant = 10
        self.collectionView.reloadData()
        self.reloadAndAdjustCollectionViewHeight()
    }
    
    private func configLayout(isEditable: Bool = false) {
        if isEditable == false {
            self.cameraBtn.isHidden = true
            self.infoEditLbl.isHidden = true
            self.infoTextView.isEditable = false
            self.nameTextFeild.isEnabled = false
            settingBtn.setImage(UIImage(named: "ic_setting"), for: .normal)
            saveChangesBtn.isHidden = true
            self.switchControl.thumbTintColor = .lightGray
        } else {
            self.cameraBtn.isHidden = false
            self.infoEditLbl.isHidden = false
            self.infoTextView.isEditable = true
            self.nameTextFeild.isEnabled = true
            settingBtn.setImage(UIImage(named: "ic_Subtract"), for: .normal)
            saveChangesBtn.isHidden = false
        }
    }
    
    private func prepareRequestModel() {
        editProfileViewModel.requestModel.userName = nameTextFeild.text ?? ""
        editProfileViewModel.requestModel.aboutInfo = infoTextView.text ?? ""
        self.updateProfileApi()
    }
    
    func prepareRemoveRequestModel(_ highlightId: String?, delete: Bool = true) {
        updateHighLightsVM.updateRemoveHighLightRequestModel.highlightId = highlightId
        updateHighLightsVM.updateRemoveHighLightRequestModel.delete = delete
        updateHighlightApi()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let fraction: CGFloat = 1 / 3
        let inset: CGFloat = 2.5
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction*1.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [headerItem]
        // after section delcaration…
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset+50, trailing: inset)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func switchEditMode(_ sender: UISwitch) {
        if sender.isOn {
            self.switchControl.thumbTintColor = .accountTypeBg
            self.isEditAble = true
            self.configLayout(isEditable: true)
            self.saveChangesBtn.isHidden = false
        } else {
            self.switchControl.thumbTintColor = .gray
            self.isEditAble = false
            self.configLayout(isEditable: false)
            self.saveChangesBtn.isHidden = true
        }
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        self.isEditingImage = .profileImage
        editProfileViewModel.objCameraGalleryClass.cameraDelegate = self
        editProfileViewModel.objCameraGalleryClass.customImagePicker(self, sender: sender)
    }
    
    @IBAction func settingAction(_ sender: UIButton) {
        if isEditAble {
            self.isEditingImage = .avtarImage
            editProfileViewModel.objCameraGalleryClass.cameraDelegate = self
            editProfileViewModel.objCameraGalleryClass.customImagePicker(self, sender: sender)
        } else {
            let vc = ScreenManager.getController(storyboard: .profile, controller: ProfileSettingsVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func saveChangesBtn(_ sender: UIButton) {
        prepareRequestModel()
    }
    
    @IBAction func highLightBtnAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .home, controller: AddRackVC.self)
        nextVC.racks = .add
        nextVC.create = .highLight
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func seeAllOutfitAction(_ sender: UIButton) {
        let vc = ScreenManager.getController(storyboard: .home, controller: MostLikedOutfitsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: - CameraGalleryDelegate Method
extension ProfileVC: CameraGalleryDelegate {
    func updatePhotoFromGallery(_ selectedImg: UIImage, _ selectedButton: UIButton) {
        DispatchQueue.main.async {
            if self.isEditingImage == .avtarImage {
                self.avtarBgImg.image = selectedImg
                self.uploadImageModel.requestModel.file = self.avtarBgImg.image
            } else {
                self.userImgView.image =  selectedImg
                self.uploadImageModel.requestModel.file = self.userImgView.image
            }
            self.uploadImageApi()
        }
    }
}

//MARK: - UIPopoverPresentationControllerDelegate Method
extension ProfileVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for: UIPresentationController) -> UIModalPresentationStyle {
        //return UIModalPresentationStyle.fullScreen
        return UIModalPresentationStyle.none
    }
}


//MARK: - UICollectionViewDataSource Methods
extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionView != nightsOutCollectionView ? 1 : viewModel.responseModel?.data.myHighlights.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == nightsOutCollectionView ? viewModel.responseModel?.data.myHighlights[section].outfits.count ?? 0 : viewModel.responseModel?.data.mostLikedOutfits.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView != nightsOutCollectionView {
            let cell = collectionView.dequeueReusableCell(with: MostLikedCVC.self, for: indexPath)
            cell.configMostLikedOutfits(viewModel.responseModel?.data.mostLikedOutfits[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: MyRackCVC.self, for: indexPath)
            cell.configHightLightData(item: viewModel.responseModel?.data.myHighlights[indexPath.section].outfits[indexPath.row])
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableView(with: SectionHeaderView.self, for: indexPath, of: "header")
        header.headerLbl.text = viewModel.responseModel?.data.myHighlights[indexPath.section].name
        header.onOption = {[weak self] in
            let nextVC = ScreenManager.getController(storyboard: .home, controller: MoreOptionsVC.self)
            nextVC.option = .Rack
            nextVC.onRename = { [weak self] in
                let nextVC = ScreenManager.getController(storyboard: .profile, controller: AddHighLightsVC.self)
                nextVC.highLight = .rename
                nextVC.viewModel.highlightId = self?.viewModel.responseModel?.data.myHighlights[indexPath.section].id ?? ""
                nextVC.viewModel.highLight = .rename
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
            nextVC.onRemoveOutfit = { [weak self] in
                let nextVC = ScreenManager.getController(storyboard: .profile, controller: AddHighLightsVC.self)
                nextVC.highLight = .edit
                nextVC.viewModel.highlightId = self?.viewModel.responseModel?.data.myHighlights[indexPath.section].id ?? ""
                nextVC.viewModel.highLight = .removeoutfits
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
            nextVC.onRemove = { [weak self] in
                self?.updateHighLightsVM.highLight = .remove
                self?.prepareRemoveRequestModel(self?.viewModel.responseModel?.data.myHighlights[indexPath.section].id)
                self?.collectionView.reloadData()
            }
            nextVC.modalPresentationStyle = .overCurrentContext
            self?.navigationController?.present(nextVC, animated: true)
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == nightsOutCollectionView {
            let nextVC = ScreenManager.getController(storyboard: .profile, controller: RackOutfitDetailsVC.self)
            nextVC.onShare = { [weak self] in
                guard let self else { return }
                let nextVC = ScreenManager.getController(storyboard: .home, controller: ShareVC.self)
                nextVC.modalPresentationStyle = .overCurrentContext
                self.navigationController?.present(nextVC, animated: true)
            }
            nextVC.onAdd = { [weak self] in
                guard let self else { return }
                let nextVC = ScreenManager.getController(storyboard: .profile, controller: AddToRackVC.self)
                nextVC.onAddToRack = { [weak self] in
                    guard let self else { return }
                    configUI()
                }
                nextVC.addTo = .highlight
                nextVC.outfitIds.append(self.viewModel.responseModel?.data.myHighlights[indexPath.section].outfits[indexPath.row].id ?? "")
                nextVC.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(nextVC, animated: true)
            }
            nextVC.modalPresentationStyle = .overFullScreen
            nextVC.viewModel.outfitId = self.viewModel.responseModel?.data.myHighlights[indexPath.section].outfits[indexPath.row].id ?? ""
            self.navigationController?.present(nextVC, animated: true)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(collectionView.frame.size.width) / 3 , height: Int(collectionView.frame.size.width) / 2)
    }
    
}


// MARK: - Networking
extension ProfileVC: AlertProtocol {
    private func getProfileApi() {
        CustomLoader.shared.show()
        self.viewModel.getProfileApi{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.configData()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func uploadImageApi() {
        CustomLoader.shared.show()
        self.uploadImageModel.uploadImage { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                if self?.isEditingImage == .avtarImage {
                    self?.editProfileViewModel.requestModel.avatar = self?.uploadImageModel.responseModel?.data?.fileUrl
                } else {
                    self?.editProfileViewModel.requestModel.profilePicture = self?.uploadImageModel.responseModel?.data?.fileUrl
                }
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func updateProfileApi() {
        CustomLoader.shared.show()
        self.editProfileViewModel.updateProfile { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(let response):
                self?.switchControl.isOn = false
                self?.showAlert(message: response.message)
                self?.configLayout(isEditable: false)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func updateHighlightApi() {
        CustomLoader.shared.show()
        self.updateHighLightsVM.updateHighLightsApi{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.getProfileApi()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}


// MARK: - UITextViewDelegate Methods
extension ProfileVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "No Info Added" {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "No Info Added"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        return newText.count <= 250
    }
    
}


// MARK: - DZNEmptyDataSetSource Methods
extension ProfileVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
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
