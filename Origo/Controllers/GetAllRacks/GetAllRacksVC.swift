//
//  GetAllRacksVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 29/02/24.
//

import UIKit



class GetAllRacksVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(FitsRecommendationsCVC.self)
        }
    }
    var viewModel = TopCreatorsVM()
    var rackViewModel = RackVM()
    var ids = [String]()
    var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
    }
    
    private func prepareRequestModel(for ids: [String]) {
        rackViewModel.requestModel.outfits = ids
        rackViewModel.requestModel.name = name
        self.addRackApi()
    }
    
    
    //MARK: - Convenience
    private func configData()  {
        self.getAllRacksApi()
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        if let arr = viewModel.allRacksResponseModel?.data.outfits {
            for item in arr where item.isSelected == true {
                ids.append(item.id ?? "")
            }
        }
        if ids.isEmpty {
            self.showAlert(message: "Please select any rack image you want to add in personlized rack")
        } else {
            self.prepareRequestModel(for: ids)
        }
    }

    
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
}

//MARK: - UICollectionViewDataSource Methods
extension GetAllRacksVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.allRacksResponseModel?.data.outfits.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: FitsRecommendationsCVC.self, for: indexPath)
        cell.configData(viewModel.allRacksResponseModel?.data.outfits[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.allRacksResponseModel?.data.outfits[indexPath.item].isSelected == true {
            viewModel.allRacksResponseModel?.data.outfits[indexPath.item].isSelected = false
        } else {
            viewModel.allRacksResponseModel?.data.outfits[indexPath.item].isSelected = true
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(collectionView.frame.size.width) / 3 , height: Int(collectionView.frame.size.width) / 2)
    }
    
}

// MARK: - Networking
extension GetAllRacksVC: AlertProtocol {
    private func getAllRacksApi() {
        CustomLoader.shared.show()
        self.viewModel.getRacksApi { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.collectionView.reloadData()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func addRackApi() {
        CustomLoader.shared.show()
        self.rackViewModel.createRack{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                let nc = UINavigationController(rootViewController: ScreenManager.getController(storyboard: .home, controller: RoundedTabbarController.self))
                if let tabBarController = nc.viewControllers.first as? RoundedTabbarController {
                    tabBarController.selectedIndex = 1
                }
                nc.setNavigationBarHidden(true, animated: false)
                UIApplication.shared.delegate?.window??.rootViewController = nc
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
}
