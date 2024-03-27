//
//  AddHighLightsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 15/03/24.
//

import UIKit

enum HighLights {
    case edit, add, rename, removeoutfits, remove
}

class AddHighLightsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(AddRackCVC.self)
            collectionView.registerNib(RemoveOutfitsCVC.self)
        }
    }
    @IBOutlet weak var rackNameTf: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var viewModel = HighLightsVM()
    var outfitids: [String] = []
    var highLight: HighLights = .add
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        rackNameTf.isEnabled = true
        rackNameTf.textAlignment = highLight == .add ? .center : .center
        saveBtn.isHidden = highLight == .rename ? false : true
        if highLight == .rename || highLight == .add {
            rackNameTf.isEnabled = true
        } else {
            rackNameTf.isEnabled = false
        }
        if highLight == .edit || highLight == .rename {
            getHighlightDetailsApi()
        }
    }
    
    private func configureData() {
        rackNameTf.text = viewModel.highLightResponseModel?.data.name
    }
    
    func prepareRequestModel() {
        viewModel.updateRemoveHighLightOutfitsRequestModel.highlightId = viewModel.highLightResponseModel?.data.id
        viewModel.updateRemoveHighLightOutfitsRequestModel.outfitId = outfitids
        updateHighLightsApi()
    }
    
    func prepareRenameRequestModel() {
        viewModel.highLightRenameRequestModel.highlightId = viewModel.highLightResponseModel?.data.id
        viewModel.highLightRenameRequestModel.highlightName = rackNameTf.text ?? ""
        updateHighLightsApi()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        self.prepareRenameRequestModel()
    }
    
}


//MARK: - UICollectionViewDataSource Methods
extension AddHighLightsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if highLight == .add {
            return 1
        } else {
            return (viewModel.highLightResponseModel?.data.outfits.count ?? 0) + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(with: AddRackCVC.self, for: indexPath)
            cell.mainView.addBottomShadow()
            cell.mainView.dropShadow()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(with: RemoveOutfitsCVC.self, for: indexPath)
            cell.removeBtn.isHidden = highLight == .rename ? true : false
            cell.configDetailsCell(viewModel.highLightResponseModel?.data.outfits[indexPath.row - 1].outfitImages)
            cell.onRemove = { [weak self] in
                self?.showAlertWithTwoActions(alertTitle: "Alert", message: "Are you sure, you want to delete this outfit?", action1Title: "No", action1Style: .cancel, action2Title: "Yes", completion1: { _ in print("no")}, completion2: { _ in
                    self?.outfitids.append(self?.viewModel.highLightResponseModel?.data.outfits[indexPath.row - 1].id ?? "")
                    self?.prepareRequestModel()
                })

            }
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size , height: size + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if (rackNameTf.text ?? "").isBlank {
                self.showAlert(message: "Hightlight name is empty!")
            } else {
                let nextVC = ScreenManager.getController(storyboard: .home, controller: AllOutfitsVC.self)
                nextVC.name = rackNameTf.text ?? ""
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        
    }
    
}


// MARK: - Networking
extension AddHighLightsVC: AlertProtocol {
    private func getHighlightDetailsApi() {
        CustomLoader.shared.show()
        self.viewModel.getHighlightDetails{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.configureData()
                self?.collectionView.reloadData()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func updateHighLightsApi() {
        CustomLoader.shared.show()
        self.viewModel.updateHighLightsApi{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                if self?.highLight == .rename {
                    self?.popVC()
                } else {
                    self?.getHighlightDetailsApi()
                }
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}

