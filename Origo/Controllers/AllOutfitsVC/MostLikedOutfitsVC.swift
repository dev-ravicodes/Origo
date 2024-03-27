//
//  MostLikedOutfitsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 22/03/24.
//

import UIKit
import DZNEmptyDataSet

class MostLikedOutfitsVC: UIViewController {
    
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
    
    
    //MARK: - Convenience
    private func configData()  {
        self.getAllusersOutfitsApi()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        popVC()
    }
    
}


//MARK: - UICollectionViewDataSource Methods
extension MostLikedOutfitsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.outfitsResponseModel?.data.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: FitsRecommendationsCVC.self, for: indexPath)
        viewModel.outfitsResponseModel?.data.data[indexPath.row].addGesture = true
        cell.configOutfitsData(viewModel.outfitsResponseModel?.data.data[indexPath.row])
        cell.selectionHandler = { [weak self] in
            guard let self else {return}
            if viewModel.outfitsResponseModel?.data.data[indexPath.row].iSelected == false {
                viewModel.outfitsResponseModel?.data.data[indexPath.row].iSelected = true
            } else {
                viewModel.outfitsResponseModel?.data.data[indexPath.row].iSelected = false
            }
            collectionView.reloadData()
        }
        cell.onRemove = { [weak self] in
            guard let self else { return }
            viewModel.outfitId = viewModel.outfitsResponseModel?.data.data[indexPath.row].id ?? ""
            deleteMyOutfitsApi()
            collectionView.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
            nextVC.addTo = .rack
            nextVC.onAddToRack = { [weak self] in
                guard let self else { return }
//                configUI()
            }
//            nextVC.outfitIds.append(viewModel.responseModel?.data[indexPath.section].outfits[indexPath.item].id ?? "")
            nextVC.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(nextVC, animated: true)
        }
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.viewModel.outfitId = viewModel.outfitsResponseModel?.data.data[indexPath.row].id ?? ""
        self.navigationController?.present(nextVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(collectionView.frame.size.width) / 3 , height: Int(collectionView.frame.size.width) / 2)
    }
    
}

// MARK: - Networking
extension MostLikedOutfitsVC: AlertProtocol {
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
    
    private func deleteMyOutfitsApi() {
        CustomLoader.shared.show()
        self.viewModel.deleteMyOutfit{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.configData()
                
            case .failure(let error):
                debugPrint(error.message)
            }
        }
    }
    
}


// MARK: - DZNEmptyDataSetSource Methods
extension MostLikedOutfitsVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
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

