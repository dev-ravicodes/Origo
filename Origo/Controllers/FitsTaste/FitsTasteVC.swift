//
//  FitsTasteVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/02/24.
//

import UIKit

class FitsTasteVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(FitsRecommendationsCVC.self)
        }
    }
    
    
    //MARK: - Variables
    var viewModel = TopCreatorsVM()
    var recommendedViewModel = SelectRecommendationOutfitsVM()
    var ids = [String]()
    var selectedCount = 0
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configData()
    }
    
    
    //MARK: - Convenience
    private func configData()  {
        self.getFitsRecommendationsApi()
    }
    
    private func prepareRequestModel(for ids: [String]) {
        recommendedViewModel.requestModel.outFitIds = ids
        self.addFitsRecommendationsApi()
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func nextAction(_ sender: UIButton) {
        if let arr = viewModel.fitsRecommendationsResponseModel?.data.data{
            for item in arr where item.isSelected == true{
                ids.append(item.id)
            }
        }
        if ids.isEmpty {
            self.showAlert(message: "Please select at least one outfit")
        } else {
            self.prepareRequestModel(for: ids)
        }
    }
    
}


//MARK: - UICollectionViewDataSource Methods
extension FitsTasteVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.fitsRecommendationsResponseModel?.data.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: FitsRecommendationsCVC.self, for: indexPath)
        cell.configData(viewModel.fitsRecommendationsResponseModel?.data.data[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Int(collectionView.frame.size.width) / 3 , height: Int(collectionView.frame.size.width) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCount < 5 || viewModel.fitsRecommendationsResponseModel?.data.data[indexPath.item].isSelected == true {
            if viewModel.fitsRecommendationsResponseModel?.data.data[indexPath.item].isSelected == true {
                viewModel.fitsRecommendationsResponseModel?.data.data[indexPath.item].isSelected = false
                selectedCount -= 1
            } else {
                viewModel.fitsRecommendationsResponseModel?.data.data[indexPath.item].isSelected = true
                selectedCount += 1
            }
        } else {
            showAlertWithText("Maximum limit reached")
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
}


// MARK: - Networking
extension FitsTasteVC: AlertProtocol {
    private func getFitsRecommendationsApi() {
        CustomLoader.shared.show()
        self.viewModel.getRecommendedOutfits { [weak self] result in
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
    
    private func addFitsRecommendationsApi() {
        CustomLoader.shared.show()
        self.recommendedViewModel.addRecommendedOutfits { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                let nextVC = ScreenManager.getController(storyboard: .home, controller: RoundedTabbarController.self)
                self?.navigationController?.pushViewController(nextVC, animated: true)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}
