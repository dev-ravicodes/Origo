//
//  AddSomethingToOutfitVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 14/03/24.
//

import UIKit

class AddSomethingToOutfitVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var itemTableView: UITableView! {
        didSet {
            itemTableView.registerNib(DescribeYourOutfitCell.self)
        }
    }
    @IBOutlet weak var shopLinkTableView: UITableView! {
        didSet {
            shopLinkTableView.registerNib(ShopLinkTVC.self)
        }
    }
    @IBOutlet weak var itemTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shopLinkTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var additionalInsightsTextView: UITextView!
    var viewModelAddOutfitVM: AddOutfitVM?
    var uploadImageModel = UploadImageVM()
    var items:[AddOutfitDetailItems] = [AddOutfitDetailItems()]
    var currentIndexPath:IndexPath?
    
    
    //MARK: - View Life Ccyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllCategories()
        self.getAllColors()
        self.getAllMaterials()
    }
    
    override func viewDidLayoutSubviews() {
        itemTableViewHeight.constant = itemTableView.contentSize.height
        self.view.layoutIfNeeded()
        
        shopLinkTableViewHeight.constant = shopLinkTableView.contentSize.height
        self.view.layoutIfNeeded()
        self.additionalInsightsTextView.delegate = self
    }
    
    
    //MARK: - Helpers
    private func navigateToPreviewWithValidation() {
        var validItems = true
        for (index, item) in items.enumerated() {
            if item.type == nil || (item.type ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                showAlert(message: "Please enter category of item \(index + 1)")
                validItems = false
                return
            }
            else if item.color == nil || (item.color ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                showAlert(message: "Please enter the color of item \(index + 1)")
                validItems = false
                
                return
            } else if item.material == nil || (item.material ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                showAlert(message: "Please enter matrial of item \(index + 1)")
                validItems = false

                return
            } else if item.brand == nil || (item.brand ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                showAlert(message: "Please enter brand of item \(index + 1)")
                validItems = false

                return
            } 
//            else if item.name == nil || (item.name ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//                showAlert(message: "Please enter item name of item \(index + 1)")
//                validItems = false
//
//                return
//            }
//            else if item.url == nil || (item.url ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//                showAlert(message: "Please enter link of item \(index + 1)")
//                validItems = false
//
//                return
//            }
            else if (item.url)?.isValidURL ==  false {
                showAlert(message: "Please enter valid link of item \(index + 1)")
                validItems = false

                return
            }
//            else if item.image == nil {
//                showAlert(message: "Please add item \(index + 1) image")
//                validItems = false
//                
//                return
//            }
        }
        
        if validItems {
                self.viewModelAddOutfitVM?.requestModel.items = self.items
                let vc = ScreenManager.getController(storyboard: .addOutfit, controller: PreviewOutfitWithItemsVC.self)
                vc.viewModelAddOutfitVM = viewModelAddOutfitVM
                self.navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func addItemAction(_sender: UIButton) {
        items.append(AddOutfitDetailItems())
        // Reload the table view to include the new item
        itemTableView.reloadData()
        viewDidLayoutSubviews()
    }
    
    @IBAction func seePreviewAction(_sender: UIButton) {
        navigateToPreviewWithValidation()
    }
    
}


extension AddSomethingToOutfitVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == itemTableView ? items.count : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == itemTableView {
            let cell = tableView.dequeueReusableCell(withClassIdentifier: DescribeYourOutfitCell.self)
            cell.delegate = self
            cell.removeBtn.isHidden = false
            if items.count == 1{
                cell.removeBtn.isHidden = true
            }
            cell.configCell(indexPath.row)
            cell.onRemove = { [weak self] in
                guard let self else {return}
                if items.count > 1{
                    items.remove(at: indexPath.item)
                    itemTableView.reloadData()
                    viewDidLayoutSubviews()
                }
                
            }
            cell.selectedDropDown = { [weak self] selectedValue in
                guard let self = self else {return}
                var optionsArray = [String]()
                 var optionHeadingValue = ""
                if selectedValue == 0 {
                    optionsArray = viewModelAddOutfitVM?.categoriesResponseModel?.data?.outfitCategory?.compactMap { $0.category } ?? []
                    optionHeadingValue = "Type"
                }else if selectedValue == 1{
                    optionsArray = viewModelAddOutfitVM?.colorResponseModel?.data?.outfitColor?.compactMap { $0.color } ?? []
                    optionHeadingValue = "Color"
                }else{
                    optionsArray = viewModelAddOutfitVM?.materialResponseModel?.data?.outfitMaterial?.compactMap { $0.material } ?? []
                    optionHeadingValue = "Material"
                }
                
                cell.onBrandChange = { [weak self] newBrand in
                    self?.items[indexPath.row].brand = newBrand
                }
                
                cell.onItemNameChange = { [weak self] newItemName in
                    self?.items[indexPath.row].name = newItemName
                }
                
                cell.onLinkChange = { [weak self] newLink in
                    self?.items[indexPath.row].url = newLink
                }
                
                let vc = ScreenManager.getController(storyboard: .addOutfit, controller: OptionsVC.self)
                vc.headingLblValue = optionHeadingValue
                vc.categoryTopConstant = 30
                vc.optionsArray = optionsArray
                vc.showInfo = .DescribeOutfit
                vc.selectedValue = { [weak self] selectedItem, selectedIndex in
                    if selectedValue == 0{
                        self?.items[indexPath.row].type = selectedItem
                        cell.setTextOfCategory(txt: selectedItem)
                    }else if selectedValue == 1{
                        self?.items[indexPath.row].color = selectedItem
                        cell.setTextOfColor(txt: selectedItem)
                    }else if selectedValue == 2{
                        self?.items[indexPath.row].material = selectedItem
                        cell.setTextOfMaterial(txt: selectedItem)
                    }
                }
                self.viewModelAddOutfitVM?.requestModel.items = items
                self.navigationController?.present(vc, animated: true)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClassIdentifier: ShopLinkTVC.self)
            
            return cell
        }
    }
    
    func didUpdateItem(cell: DescribeYourOutfitCell, item: AddOutfitDetailItems) {
        
        guard let indexPath = itemTableView.indexPath(for: cell) else { return }
        items[indexPath.row] = item
        // Now 'items' array has the updated data which you can use elsewhere
    }
    
    
}

extension AddSomethingToOutfitVC: AlertProtocol{
    private func getAllCategories() {
        CustomLoader.shared.show()
        self.viewModelAddOutfitVM?.getAllCategories { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_): break
                
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    private func getAllColors() {
        CustomLoader.shared.show()
        self.viewModelAddOutfitVM?.getAllColors { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_): break
                
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    private func getAllMaterials() {
        CustomLoader.shared.show()
        self.viewModelAddOutfitVM?.getAllMaterials { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_): break
                
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func uploadImageApi(indexPath: IndexPath) {
        CustomLoader.shared.show()
        self.uploadImageModel.uploadImage { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                guard let strongSelf = self else {return}
                
                if let fileUrl = strongSelf.uploadImageModel.responseModel?.data?.fileUrl {
                    // Check if the 'image' array exists, if not, create it
                    if strongSelf.items[indexPath.row].image == nil {
                        strongSelf.items[indexPath.row].image = []
                    }
                    
                    // Append the new file URL or replace at specific index if necessary
                    strongSelf.items[indexPath.row].image?.append(fileUrl)
                    
                    // Now, 'items' array has the updated image URL
                    // Reload the specific row in your table view if needed to reflect the changes
                    
                }
                
                
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}

extension AddSomethingToOutfitVC: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        let currentText = textView.text
        self.viewModelAddOutfitVM?.requestModel.description = currentText
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type here..." {
            textView.text = nil
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           // Current text in the text view
           let currentText = textView.text ?? ""
           
           // Potential new text if we allow the user's latest edit
           guard let stringRange = Range(range, in: currentText) else { return false }
           let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
           
           // Check if the updated text is within the limit and return accordingly
           return updatedText.count <= 250
       }
}


extension AddSomethingToOutfitVC: CustomCellDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func didRequestPhotoPicker(cell: DescribeYourOutfitCell,currentIndex: Int) {
        let indexPath = itemTableView.indexPath(for: cell)
        currentIndexPath = indexPath
        if currentIndex == 1{
              // Store this indexPath for later reference
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            let alert = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    picker.sourceType = .camera
                    self.present(picker, animated: true)
                }))
            }
            alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }else{
            cell.addItemPic.isSelected = false
            self.items[indexPath?.row ?? 0].image?.remove(at: 0)
            cell.addItemPic.setImage(UIImage(named: "ic_addIconUploadImg"), for: .normal)
            
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // Update the cell's button with the selected image
            if let indexPath = currentIndexPath,
               let cell = itemTableView.cellForRow(at: indexPath) as? DescribeYourOutfitCell {
                cell.updateButtonWithImage(editedImage)
                self.uploadImageModel.requestModel.file = editedImage
                uploadImageApi(indexPath: indexPath)
            }
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
