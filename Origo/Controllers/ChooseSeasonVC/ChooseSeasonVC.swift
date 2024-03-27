//
//  ChooseSeasonVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 14/03/24.
//

import UIKit

class ChooseSeasonVC: UIViewController {

    @IBOutlet var styleOptionsView: UIView!
    @IBOutlet weak var selectStyleView: UIView!
    @IBOutlet weak var yesToAddSomethingBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var noToAddSomethingBtn: UIButton!
    @IBOutlet weak var fallWinterBtn: UIButton!
    @IBOutlet weak var springSummerBtn: UIButton!
    @IBOutlet weak var selectedStyleLbl: UITextField!
    @IBOutlet weak var lblAddSomething: UILabel!

    var viewModelAddOutfitVM: AddOutfitVM?
    
    var styleOptionArray = ["1. Carefree","2. Everyday","3. Elevated Everyday","4. Dressy","5. Formal or Professional"]
    var seasonIsSummer = false
    var wantToAddSomething = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    private func configLblUI() {
        let fullString = NSMutableAttributedString(string: "Would you like to add something? ")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "ic_detailsIcon")
        let newSize = CGRect(x: 0, y: -3.2, width: 18, height: 18)
        imageAttachment.bounds = newSize
        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(imageString)
        lblAddSomething.attributedText = fullString
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showBlurbMessage(tapGesture:)))
        self.lblAddSomething.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: - Objc Methods
    @objc func showBlurbMessage(tapGesture: UITapGestureRecognizer) {
        let location = (lblAddSomething.text?.count ?? 0)
        self.showInfoPoup(sender: lblAddSomething, text: "To enhance the overall user experience, outfits with additional info will be granted increased visibility.")
    }
    
    private func showInfoPoup(sender: UILabel, text: String) {
        let vc = ScreenManager.getController(storyboard: .authentication, controller: InfoVC.self)
        vc.descText = text
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
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
    @IBAction func springBtnAction(_ sender: UIButton) {
        self.seasonIsSummer = true
        self.setUpUI()
    }
    
    @IBAction func fallBtnAction(_ sender: UIButton) {
        self.seasonIsSummer = false
        self.setUpUI()
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.popVC()
    }
    @IBAction func noAction(_ sender: UIButton) {
        self.wantToAddSomething = false
        self.setUpUI()
    }
    
    @IBAction func yesAction(_sender: UIButton) {
        self.wantToAddSomething = true
        self.setUpUI()
        
    }
    @IBAction func nextBtnAction(_ sender: UIButton) {
        if selectedStyleLbl.text == "Select an option" {
            self.showAlert(message: "Please choose Style!")
        }else {
            if wantToAddSomething{
                let vc = ScreenManager.getController(storyboard: .home, controller: AddSomethingToOutfitVC.self)
                vc.viewModelAddOutfitVM = self.viewModelAddOutfitVM
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let vc = ScreenManager.getController(storyboard: .addOutfit, controller: PreviewOutfitVC.self)
                vc.viewModelAddOutfitVM = self.viewModelAddOutfitVM
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @objc func tapActionOnSelectStyleView(){
        showStyleOptions()
    }
    
}

extension ChooseSeasonVC{
    func setUpUI() {
        self.selectStyleView.isUserInteractionEnabled = true
        let tapGestureOnSelectStyleView = UITapGestureRecognizer(target: self, action: #selector(tapActionOnSelectStyleView))
        self.selectStyleView.addGestureRecognizer(tapGestureOnSelectStyleView)
        yesToAddSomethingBtn.backgroundColor = wantToAddSomething ? UIColor.accountTypeColor : UIColor.buttonBGColor
        noToAddSomethingBtn.backgroundColor = !wantToAddSomething ? UIColor.accountTypeColor : UIColor.buttonBGColor
        fallWinterBtn.backgroundColor = !seasonIsSummer ? UIColor.accountTypeColor : UIColor.buttonBGColor
        springSummerBtn.backgroundColor = seasonIsSummer ? UIColor.accountTypeColor : UIColor.buttonBGColor
        if wantToAddSomething{
            nextBtn.setTitle("Next", for: .normal)
        }else{
            nextBtn.setTitle("See preview", for: .normal)
        }
        viewModelAddOutfitVM?.requestModel.season = seasonIsSummer ? "Spring/Summer" : "Fall/Winter"
        configLblUI()
    }
    
    func showStyleOptions() {
        let vc = ScreenManager.getController(storyboard: .addOutfit, controller: OptionsVC.self)
        vc.headingLblValue = "Style"
        vc.optionsArray = styleOptionArray
        vc.showInfo = .ShowInfo
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.selectedValue = { [weak self] (selectedValue, selectedIndex) in
            guard let self = self else {return}
            print(selectedValue)
            selectedStyleLbl.text = selectedValue
            viewModelAddOutfitVM?.requestModel.styleName = selectedValue
            viewModelAddOutfitVM?.requestModel.style = "\(selectedIndex)"
            selectedStyleLbl.textColor = .darkGray
            selectedStyleLbl.font = AppFont.medium.fontWithSize(16.0)
        }
        self.navigationController?.present(vc, animated: true)
    }
}
