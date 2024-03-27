//
//  AllOutfitsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 12/03/24.
//

import UIKit
import DZNEmptyDataSet

class AllOutfitsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(FitsRecommendationsCVC.self)
            collectionView.emptyDataSetSource = self
        }
    }

    var viewModel = ProfileVM()
    var ids = [String]()
    var name = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
    }
    
    private func prepareRequestModel(for ids: [String]) {
        viewModel.requestModelHighLight.outfits = ids
        viewModel.requestModelHighLight.name = name
        self.createHighLightApi()
    }
    
    
    //MARK: - Convenience
    private func configData()  {
        self.getAllusersOutfitsApi()
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        if let arr = viewModel.outfitsResponseModel?.data.data {
            for item in arr where item.iSelected == true {
                ids.append(item.id)
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
extension AllOutfitsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.outfitsResponseModel?.data.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: FitsRecommendationsCVC.self, for: indexPath)
        cell.configOutfitsData(viewModel.outfitsResponseModel?.data.data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.outfitsResponseModel?.data.data[indexPath.item].iSelected == true {
            viewModel.outfitsResponseModel?.data.data[indexPath.item].iSelected = false
        } else {
            viewModel.outfitsResponseModel?.data.data[indexPath.item].iSelected = true
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = Int(collectionView.bounds.width / 3)

        return CGSize(width: widthPerItem, height: Int(collectionView.frame.size.width) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
}


// MARK: - Networking
extension AllOutfitsVC: AlertProtocol {
    private func getAllusersOutfitsApi() {
        CustomLoader.shared.show()
        self.viewModel.getOwnOutfitsApi{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.collectionView.reloadData()
                
            case .failure(let error):
                debugPrint(error.message)
            }
        }
    }
    
    private func createHighLightApi() {
        CustomLoader.shared.show()
        self.viewModel.createHighLight{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.navigationController?.popToViewController(ofClass: ProfileVC.self, animated: true)
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
}


// MARK: - DZNEmptyDataSetSource Methods
extension AllOutfitsVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "No data found"
        
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
