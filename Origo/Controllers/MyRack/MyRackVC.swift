//
//  MyRockVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 22/02/24.
//

import UIKit
import DZNEmptyDataSet

class MyRackVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.registerNib(MyRackCVC.self)
            self.collectionView.registerCollectionResuableView(SectionHeaderView.self, kind: "header")
            self.collectionView.emptyDataSetSource = self
            self.collectionView.collectionViewLayout = layout()
        }
    }
    
    var viewModel = HangItVM()
    var updateRackVM = RackVM()
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configUI()
    }
    
    
    //MARK: - Conveinces
    private func configUI() {
        getAllRacksApis()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let fraction: CGFloat = 1 / 3
        let inset: CGFloat = 2.5
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction*1.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "footer", alignment: .bottom) // Add footer item
        
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [headerItem]
        // after section delcaration…
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset+50, trailing: inset)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func prepareRequestModel(_ rackId: String?, visibility: Bool = false) {
        updateRackVM.updateRequestModel.rackId = rackId
        updateRackVM.updateRequestModel.visibility = visibility
        updateRackApi()
    }
    
    func prepareRemoveRequestModel(_ rackId: String?, delete: Bool = true) {
        updateRackVM.updateRemoveRackRequestModel.rackId = rackId
        updateRackVM.updateRemoveRackRequestModel.delete = delete
        updateRackApi()
    }
    
    func prepareRemoveOutfitsRequestModel(rackId: String?, outfitIds: [String]) {
        updateRackVM.updateRemoveRackOutfitsRequestModel.rackId = rackId
        updateRackVM.updateRemoveRackOutfitsRequestModel.outfitId = outfitIds
        updateRackApi()
    }
    
    //MARK: - Interface Builder Actions
    @IBAction func addRackAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .home, controller: AddRackVC.self)
        nextVC.racks = .add
        nextVC.create = .rack
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func profileAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .profile, controller: ProfileVC.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func settingAction(_ sender: UIButton) {
        let vc = ScreenManager.getController(storyboard: .profile, controller: ProfileSettingsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK: - UICollectionViewDataSource & UICollectionViewDelegate Methods
extension MyRackVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.responseModel?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.responseModel?.data[section].outfits.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: MyRackCVC.self, for: indexPath)
        viewModel.responseModel?.data[indexPath.section].outfits[indexPath.item].section = indexPath.section
        cell.configData(item: viewModel.responseModel?.data[indexPath.section].outfits[indexPath.item])
        cell.selectionHandler = { [weak self] in
            guard let self else {return}
            if viewModel.responseModel?.data[indexPath.section].outfits[indexPath.item].isSelected == false {
                viewModel.responseModel?.data[indexPath.section].outfits[indexPath.item].isSelected = true
            } else {
                viewModel.responseModel?.data[indexPath.section].outfits[indexPath.item].isSelected = false
            }
            collectionView.reloadData()
        }
        cell.onRemove = { [weak self] in
            guard let self else { return }
            updateRackVM.rack = .removeOutfit
            var outfits = [String]()
            outfits.append(viewModel.responseModel?.data[indexPath.section].outfits[indexPath.row].id ?? "")
            prepareRemoveOutfitsRequestModel(rackId: viewModel.responseModel?.data[indexPath.section].id, outfitIds: outfits)
            collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableView(with: SectionHeaderView.self, for: indexPath, of: "header")
        header.moreOPtionBtn.isHidden = indexPath.section == 0 ? true : false
        header.headerLbl.text = viewModel.responseModel?.data[indexPath.section].name
        header.onOption = { [weak self] in
            let nextVC = ScreenManager.getController(storyboard: .home, controller: MoreOptionsVC.self)
            nextVC.option = .Rack
            nextVC.onRename = { [weak self] in
                let nextVC = ScreenManager.getController(storyboard: .home, controller: AddRackVC.self)
                nextVC.racks = .rename
                nextVC.viewModel.rackId = self?.viewModel.responseModel?.data[indexPath.section].id ?? ""
                nextVC.viewModel.rack = .Rename
                nextVC.create = .rack
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
            nextVC.onHide = { [weak self] in
                self?.updateRackVM.rack = .hide
                self?.prepareRequestModel(self?.viewModel.responseModel?.data[indexPath.section].id)
                self?.collectionView.reloadData()
            }
            nextVC.onRemoveOutfit = { [weak self] in
                let nextVC = ScreenManager.getController(storyboard: .home, controller: AddRackVC.self)
                nextVC.racks = .edit
                nextVC.viewModel.rackId = self?.viewModel.responseModel?.data[indexPath.section].id ?? ""
                nextVC.viewModel.rack = .removeOutfit
                nextVC.create = .rack
                self?.navigationController?.pushViewController(nextVC, animated: true)
            }
            nextVC.onRemove = { [weak self] in
                self?.updateRackVM.rack = .remove
                self?.prepareRemoveRequestModel(self?.viewModel.responseModel?.data[indexPath.section].id)
                self?.collectionView.reloadData()
            }
            nextVC.modalPresentationStyle = .overCurrentContext
            self?.navigationController?.present(nextVC, animated: true)
        }
        
        return header
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
            nextVC.onAddToRack = { [weak self] in
                guard let self else { return }
                configUI()
            }
            nextVC.addTo = .rack
            nextVC.outfitIds.append(viewModel.responseModel?.data[indexPath.section].outfits[indexPath.item].id ?? "")
            nextVC.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(nextVC, animated: true)
        }
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.viewModel.outfitId = viewModel.responseModel?.data[indexPath.section].outfits[indexPath.item].id ?? ""
        self.navigationController?.present(nextVC, animated: true)
    }
    
}


// MARK: - Networking
extension MyRackVC: AlertProtocol {
    private func getAllRacksApis() {
        CustomLoader.shared.show()
        self.viewModel.gatAllRacks { [weak self] result in
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
    
    private func updateRackApi() {
        CustomLoader.shared.show()
        self.updateRackVM.updateRack{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.getAllRacksApis()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
}


// MARK: - DZNEmptyDataSetSource Methods
extension MyRackVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "No data added"
        
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
