//
//  DescribeYourOutfitCell.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 14/03/24.
//

import UIKit
//protocol ItemCellDelegate: AnyObject {
//    func didUpdateItem(cell: DescribeYourOutfitCell, item: AddOutfitDetailItems)
//}
protocol CustomCellDelegate: AnyObject {
    func didRequestPhotoPicker(cell: DescribeYourOutfitCell, currentIndex: Int)
}
class DescribeYourOutfitCell: UITableViewCell {
     weak var delegate: CustomCellDelegate?
    
    @IBOutlet weak var itemLable: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var materialTF: UITextField!
    @IBOutlet weak var addItemPic: UIButton!
    @IBOutlet weak var colorTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var linkTF: UITextField!
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var brandTF: UITextField!
    @IBOutlet weak var materialView: UIView!
    @IBOutlet weak var removeBtn: UIButton!
    var onRemove: (()->())?
    var isImageAvailable = false
    
    
    
   
    var selectedDropDown: ((Int) -> Void )?
    weak var textFieldDelegate: UITextFieldDelegate?
    var onBrandChange: ((String?) -> Void)?
    var onItemNameChange: ((String?) -> Void)?
    var onLinkChange: ((String?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureOnCategoryView = UITapGestureRecognizer(target: self, action: #selector(categoryViewTapped))
        categoryView.addGestureRecognizer(tapGestureOnCategoryView)
        categoryView.isUserInteractionEnabled = true
        
        let tapGestureOnColorView = UITapGestureRecognizer(target: self, action: #selector(colorViewTapped))
        colorView.addGestureRecognizer(tapGestureOnColorView)
        colorView.isUserInteractionEnabled = true
        
        let tapGestureOnMaterialView = UITapGestureRecognizer(target: self, action: #selector(materialViewTapped))
        materialView.addGestureRecognizer(tapGestureOnMaterialView)
        materialView.isUserInteractionEnabled = true
        
        brandTF.addTarget(self, action: #selector(brandTextFieldDidChange(_:)), for: .editingChanged)
                itemNameTF.addTarget(self, action: #selector(itemNameTextFieldDidChange(_:)), for: .editingChanged)
                linkTF.addTarget(self, action: #selector(linkTextFieldDidChange(_:)), for: .editingChanged)
        
    }

        @IBAction func addItemPicButtonTapped(_ sender: UIButton) {
            if !isImageAvailable {
                isImageAvailable = true
                self.delegate?.didRequestPhotoPicker(cell: self,currentIndex: 1)
            }else{
                isImageAvailable = false
                let vc = ScreenManager.getController(storyboard: .addOutfit, controller: ChangeImagePopUpVC.self)
                vc.getBtnIndex = {currentIndex in
                    
                        self.delegate?.didRequestPhotoPicker(cell: self,currentIndex: currentIndex)
                    
                }
                UIApplication.topViewController()?.present(vc, animated: true)
                    
                       
                    
                   
                
            }
           
            
        }
    
    @IBAction func removeOutfitAction(_ sender: UIButton) {
        self.onRemove?()
    }
    func configCell(_ index: Int) {
        itemLable.text = "Item \(index + 1)"
    }
    
    
    func setTextOfCategory(txt: String){
        categoryTF.text = txt
        categoryTF.font = AppFont.medium.fontWithSize(16.0)
    }
    
    func setTextOfColor(txt: String){
        colorTF.text = txt
        colorTF.font = AppFont.medium.fontWithSize(16.0)
        
    }
    func setTextOfMaterial(txt: String){
        materialTF.text = txt
        materialTF.font = AppFont.medium.fontWithSize(16.0)
    }
    
    func updateButtonWithImage(_ image: UIImage) {
        addItemPic.isSelected = true
        }
    
    @objc func categoryViewTapped() {
        selectedDropDown?(0)
    }
    @objc func colorViewTapped() {
        selectedDropDown?(1)
    }
    @objc func materialViewTapped() {
        selectedDropDown?(2)
    }
    @objc func brandTextFieldDidChange(_ textField: UITextField) {
           onBrandChange?(textField.text)
       }

       @objc func itemNameTextFieldDidChange(_ textField: UITextField) {
           onItemNameChange?(textField.text)
       }

       @objc func linkTextFieldDidChange(_ textField: UITextField) {
           onLinkChange?(textField.text)
       }
}
