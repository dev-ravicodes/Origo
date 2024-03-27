//
//  RackOutfitDetailsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 06/03/24.
//

import UIKit
import DZNEmptyDataSet

class RackOutfitDetailsVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet var creatorName: UILabel!
    @IBOutlet weak var outfitColltionView: UICollectionView! {
        didSet {
            outfitColltionView.registerNib(OutfitDetailsCVC.self)
        }
    }
    @IBOutlet weak var outfitCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var addTo: UIButton!
    @IBOutlet var outfitCountLbl: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(ExpolreItemTVC.self)
        }
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(OutfitItemsdetailsCVC.self)
            collectionView.emptyDataSetSource = self
            
        }
    }
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    var viewModel = OutfitsDetailsVM()
    var onShare: (()->())?
    var onAdd: (()->())?
    var currentIndex = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    
    override func viewWillLayoutSubviews() {
        tableViewHeight.constant = self.tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    private func configUI() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        self.getAllusersOutfitsApi()
    }
    
    private func configData() {
        self.creatorName.text = viewModel.responseModel?.data.userID.userName
        self.descTextView.text = viewModel.responseModel?.data.description
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                self.dismiss(animated: true)
            }
        }
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func addToAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.onAdd?()
        }
    }
    
    @IBAction func buyAction(_ sender: UIButton) {
        openExternalURL(self.viewModel.responseModel?.data.items[currentIndex].url ?? "")
    }


       private func openExternalURL(_ urlString: String) {
           guard let url = URL(string: urlString) else {
               self.showAlertWithText("Invalid URL")
               
             
               return
           }
           
           let application = UIApplication.shared
           if application.canOpenURL(url) {
               application.open(url, options: [:]) { success in
                   if !success {
                       
                       print("Failed to open URL: \(urlString)")
                     
                   }
               }
           } else {
               print("Cannot open URL: \(urlString)")
              
           }
       }
    
    
    @IBAction func shareBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.onShare?()
        }
    }
    
}


//MARK: - UICollectionViewDataSource & UICollectionViewDelegate Methods
extension RackOutfitDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == outfitColltionView {
            return viewModel.responseModel?.data.outfitImages.count ?? 0
        } else {
            return viewModel.responseModel?.data.items.count ?? 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == outfitColltionView {
            let cell = collectionView.dequeueReusableCell(with: OutfitDetailsCVC.self, for: indexPath)
            cell.configDetailsCell(viewModel.responseModel?.data.outfitImages[indexPath.row])
            
            return cell
        } else {     
            let cell = collectionView.dequeueReusableCell(with: OutfitItemsdetailsCVC.self, for: indexPath)
            cell.configCell(viewModel.responseModel?.data.items[indexPath.row])
            
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        if let arr = viewModel.responseModel?.data.items {
            for i in arr.indices {
                viewModel.responseModel?.data.items[i].isSelected = false
            }
            viewModel.responseModel?.data.items[indexPath.row].isSelected = true
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var noOfCellsInRow = 1
        noOfCellsInRow = collectionView == outfitColltionView ? 1 : 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        let cellHeight = collectionView.frame.size.height
        
        return CGSize(width: size , height: Int(cellHeight))
    }
    
}


extension RackOutfitDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.responseModel?.data.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: ExpolreItemTVC.self, for: indexPath)
        cell.configCell(viewModel.responseModel?.data.items[indexPath.row])
        
        return cell
    }
    
}


// MARK: - Networking
extension RackOutfitDetailsVC: AlertProtocol {
    private func getAllusersOutfitsApi() {
        CustomLoader.shared.show()
        self.viewModel.getOutfitDetails{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.configData()
                if self?.viewModel.responseModel?.data.items.isEmpty == false {
                    self?.viewModel.responseModel?.data.items[0].isSelected = true
                }
                self?.outfitColltionView.reloadData()
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
}


// MARK: - DZNEmptyDataSetSource Methods
extension RackOutfitDetailsVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
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
