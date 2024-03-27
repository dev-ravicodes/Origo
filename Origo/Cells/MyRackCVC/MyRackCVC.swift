//
//  MyRockCVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 26/02/24.
//

import UIKit

class MyRackCVC: UICollectionViewCell {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var imgView: UIImageView!
    @IBOutlet weak var removeBtn: UIButton!
    
    
    //MARK: - Varibales
    private var longPressGestureRecognizer: UILongPressGestureRecognizer!
    var onRemove: (()->())?
    var selectionHandler:(()->())?
    
    
    //MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        configData()
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func removeAction(_ sender: UIButton) {
        self.onRemove?()
    }
    
    
    //MARK: - Convenience
    func configData() {
        configureShadow()
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            selectionHandler?()
        }
    }
    
    private func configureShadow() {
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainView.layer.shadowRadius = 2
        mainView.layer.masksToBounds = false
        mainView.layer.shouldRasterize = true
        mainView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func configData(item: Outfit?) {
        if item?.section == 0 {
            longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            self.addGestureRecognizer(longPressGestureRecognizer)
        }
        removeBtn.isHidden = item?.isSelected == true ? false : true
        if item?.outfitImages.isEmpty == false {
            guard let img = item?.outfitImages[0] else {return}
            if !(img.isBlank) {
                imgView.setImageWithKF(img)
            }
        }
    }
    
    func configHightLightData(item: ProfileOutfit?) {
        if item?.outfitImages.isEmpty == false {
            guard let img = item?.outfitImages.first else {return}
            if !(img.isBlank) {
                imgView.setImageWithKF(img)
            }
        }
    }
    
}
