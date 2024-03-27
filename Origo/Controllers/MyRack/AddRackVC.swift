//
//  AddRackVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 28/02/24.
//

import UIKit

enum Racks {
    case edit, add, rename
}

enum Create {
    case highLight, rack
}

class AddRackVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(AddRackCVC.self)
            collectionView.registerNib(RemoveOutfitsCVC.self)
        }
    }
    @IBOutlet weak var rackNameTf: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var viewModel = RackVM()
    var outfitids: [String] = []
    var racks: Racks = .add
    var create: Create = .highLight
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        rackNameTf.isEnabled = true
        rackNameTf.textAlignment = racks == .add ? .center : .center
        saveBtn.isHidden = racks == .rename ? false : true
        if racks == .rename || racks == .add {
            rackNameTf.isEnabled = true
        } else {
            rackNameTf.isEnabled = false
        }
        if racks == .edit || racks == .rename {
            getRackDetailsApi()
        }
    }
    
    private func configureData() {
        rackNameTf.text = viewModel.rackResponseModel?.data.name
    }
    
    func prepareRequestModel() {
        viewModel.updateRemoveRackOutfitsRequestModel.rackId = viewModel.rackResponseModel?.data.id
        viewModel.updateRemoveRackOutfitsRequestModel.outfitId = outfitids
        updateRackApi()
    }
    
    func prepareRenameRequestModel() {
        viewModel.updateRenameRackOutfitsRequestModel.rackId = viewModel.rackResponseModel?.data.id
        viewModel.updateRenameRackOutfitsRequestModel.rackName = rackNameTf.text ?? ""
        updateRackApi()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        self.prepareRenameRequestModel()
    }
    
}


//MARK: - UICollectionViewDataSource Methods
extension AddRackVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if racks == .add {
            return 1
        } else {
            return (viewModel.rackResponseModel?.data.outfits.count ?? 0) + 1
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
            cell.removeBtn.isHidden = racks == .rename ? true : false
            cell.configDetailsCell(viewModel.rackResponseModel?.data.outfits[indexPath.row - 1].outfitImages)
            cell.onRemove = { [weak self] in
                self?.outfitids.append(self?.viewModel.rackResponseModel?.data.outfits[indexPath.row - 1].id ?? "")
                self?.prepareRequestModel()
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
                if create == .rack {
                    self.showAlert(message: "Please enter rack name")
                } else {
                    self.showAlert(message: "Please select any outfit you want to add in the highlight")
                }
            } else {
                
                if create == .rack {
                    let nextVC = ScreenManager.getController(storyboard: .home, controller: GetAllRacksVC.self)
                    nextVC.rackViewModel.rackId = viewModel.rackResponseModel?.data.id ?? ""
                    nextVC.name = rackNameTf.text ?? ""
                    self.navigationController?.pushViewController(nextVC, animated: true)
                } else {
                    let nextVC = ScreenManager.getController(storyboard: .home, controller: AllOutfitsVC.self)
                    nextVC.name = rackNameTf.text ?? ""
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                
            }
        }
        
    }
    
}

// MARK: - Networking
extension AddRackVC: AlertProtocol {
    private func getRackDetailsApi() {
        CustomLoader.shared.show()
        self.viewModel.getRackDetails{ [weak self] result in
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
    
    private func updateRackApi() {
        CustomLoader.shared.show()
        self.viewModel.updateRack{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                if self?.racks == .rename {
                    self?.popVC()
                } else {
                    self?.getRackDetailsApi()
                }
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}
