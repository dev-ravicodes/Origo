//
//  PreviewOutfitWithItemsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 20/03/24.
//

import UIKit
import DZNEmptyDataSet

class PreviewOutfitWithItemsVC: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var creatorView: UIView!
    @IBOutlet weak var designersView: UIView!
    @IBOutlet var redirectionToHomeView: UIView!
    @IBOutlet var rankingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.registerNib(OutfitPreviewCVC.self)
        }
    }
    @IBOutlet weak var creatorDescLbl: UILabel!
    @IBOutlet weak var creatorHeadingLbl: UILabel!
    @IBOutlet weak var designerDescLbl: UILabel!
    @IBOutlet weak var designerHeadingLbl: UILabel!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(ExpolreItemTVC.self)
        }
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var itemsCollectionView: UICollectionView! {
        didSet {
            itemsCollectionView.registerNib(OutfitItemsdetailsCVC.self)
            itemsCollectionView.emptyDataSetSource = self
            
        }
    }
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblRanking: UILabel!
    
    var viewModelAddOutfitVM: AddOutfitVM?
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
    
    private func configLblUI() {
        let fullString = NSMutableAttributedString(string: "Which ranking would you like to join?")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "ic_detailsIcon")
        let newSize = CGRect(x: 0, y: -3.2, width: 18, height: 18)
        imageAttachment.bounds = newSize
        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(imageString)
        lblRanking.attributedText = fullString
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showBlurbMessage(tapGesture:)))
        self.lblRanking.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: - Objc Methods
    @objc func showBlurbMessage(tapGesture: UITapGestureRecognizer) {
        let location = (lblRanking.text?.count ?? 0)
        self.showInfoPoup()
    }
    
    private func showInfoPoup() {
        let vc = ScreenManager.getController(storyboard: .authentication, controller: OutfitInfoVC.self)
        vc.viaUploadOutfit = true
        vc.imageName = "ic_RankingInfo"
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    //MARK: - Actions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.popVC()
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 1001:
            self.popVC()
            break
        case 1002:
            //           next button action here
            
            break
        case 1003:
            //            hang item action here
            break
        case 1004:
            
            addRankingView()
            break
        case 1005:
            let nextVC = ScreenManager.getController(storyboard: .profile, controller: ProfileVC.self)
            self.navigationController?.pushViewController(nextVC, animated: true)
            break
        case 1006:
            moreOptionBtnAction()
            break
        default:
            break
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        
        switch tappedView {
        case designersView:
            self.designersView.backgroundColor = .accountTypeBg
            self.designerHeadingLbl.textColor = .white
            self.designerDescLbl.textColor = .white
            
            self.creatorView.backgroundColor = .white
            self.creatorHeadingLbl.textColor = .buttonBGColor
            self.creatorDescLbl.textColor = .buttonBGColor
            viewModelAddOutfitVM?.requestModel.rankingType = "brand"
            
        case creatorView:
            self.creatorView.backgroundColor = .accountTypeBg
            self.creatorHeadingLbl.textColor = .white
            self.creatorDescLbl.textColor = .white
            
            self.designersView.backgroundColor = .white
            self.designerHeadingLbl.textColor = .buttonBGColor
            self.designerDescLbl.textColor = .buttonBGColor
            viewModelAddOutfitVM?.requestModel.rankingType = "creator"

        default:
            break
        }
    }
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.uploadOutfit()
        })
    }
    
    func setView(_ view: UIView, andHLabel hLabel: UILabel, andDLabel dLabel: UILabel, selected: Bool) {
        if selected {
            view.backgroundColor = .accountTypeBg
            hLabel.textColor = .white
            dLabel.textColor = .white
        } else {
            view.backgroundColor = .clear
            hLabel.textColor = .buttonBGColor
            dLabel.textColor = .buttonBGColor
        }
    }
    
}


//MARK: - UICollectionViewDataSource
extension PreviewOutfitWithItemsVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView != itemsCollectionView {
            return viewModelAddOutfitVM?.requestModel.outfitImages?.count ?? 0
        } else {
            return viewModelAddOutfitVM?.requestModel.items?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView != itemsCollectionView {
            let cell = collectionView.dequeueReusableCell(with: OutfitPreviewCVC.self, for: indexPath)
            let currentObj = viewModelAddOutfitVM?.requestModel.outfitImages?[indexPath.row]
            cell.imageView.setImageWithKF(currentObj)
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(with: OutfitItemsdetailsCVC.self, for: indexPath)
            cell.configCellPreview(viewModelAddOutfitVM?.requestModel.items?[indexPath.row])
            
            return cell
        }
        
    }
    
}

extension PreviewOutfitWithItemsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModelAddOutfitVM?.requestModel.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: ExpolreItemTVC.self, for: indexPath)
        cell.configCellPreview(viewModelAddOutfitVM?.requestModel.items?[indexPath.row])
        
        return cell
    }
    
}


//MARK: - UICollectionViewDelegate
extension PreviewOutfitWithItemsVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexpath",indexPath.item)
    }
    
}
//MARK: - UICollectionViewDelegateFlowLayout
extension PreviewOutfitWithItemsVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView != itemsCollectionView {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }  else {
            let noOfCellsInRow = 3
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            let cellHeight = collectionView.frame.size.height * 0.85
            
            return CGSize(width: size - 20, height: Int(cellHeight))
        }
    }
    
}

extension PreviewOutfitWithItemsVC{
    
    func moreOptionBtnAction(){
        let nextVC = ScreenManager.getController(storyboard: .home, controller: MoreOptionsVC.self)
        nextVC.onSetting = { [weak self] in
            let nextVC = ScreenManager.getController(storyboard: .profile, controller: ProfileSettingsVC.self)
            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
        nextVC.onPreviousOutfit = { [weak self] in
        }
        nextVC.onReport = { [weak self] in
            let nextVC = ScreenManager.getController(storyboard: .home, controller: ReportOutfitsVC.self)
            nextVC.modalPresentationStyle = .overCurrentContext
            self?.navigationController?.present(nextVC, animated: true)
        }
        nextVC.option = .More
        //        nextVC.outfitIndex = koladaView.currentCardIndex
        nextVC.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(nextVC, animated: true)
    }
    
    func addRankingView() {
        let bgView = UIView()
        bgView.frame = self.view.bounds
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addSubview(bgView)
        
        // Calculate width and height as 80% and 70% of bgView's dimensions
        let rankingViewWidth = 343.0
        let rankingViewHeight = 618.0
        
        // Calculate x and y to center rankingView within bgView
        let rankingViewX = (bgView.frame.width - rankingViewWidth) / 2
        let rankingViewY = (bgView.frame.height - rankingViewHeight) / 2
        
        // Set the frame for rankingView with calculated dimensions and position
        rankingView.frame = CGRect(x: rankingViewX, y: rankingViewY, width: rankingViewWidth, height: rankingViewHeight)
        rankingView.layer.cornerRadius = 15
        rankingView.clipsToBounds = true
        rankingView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Start with half the size
        rankingView.alpha = 0 // Start fully transparent
        
        // Add the rankingView offscreen or invisible before animating
        bgView.addSubview(rankingView)
        
        // Animate the background view to fade in
        UIView.animate(withDuration: 0.3, animations: {
            bgView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        })
        
        // Animate the rankingView to grow and fade in
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
            self.rankingView.transform = CGAffineTransform.identity // Scale to normal size
            self.rankingView.alpha = 1 // Fade in to fully opaque
        }, completion: nil)
        bgView.addSubview(rankingView)
    }
    
    func setUPUI(){
        let designersTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        designersView.addGestureRecognizer(designersTapGesture)
        designersView.isUserInteractionEnabled = true // Make sure user interaction is enabled
        
        let creatorsTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        creatorView.addGestureRecognizer(creatorsTapGesture)
        creatorView.isUserInteractionEnabled = true // Make sure user interaction is enabled
        
        // Initial state
        viewModelAddOutfitVM?.requestModel.rankingType = "brand"
        setView(designersView, andHLabel: designerHeadingLbl, andDLabel: designerDescLbl, selected: true)
        setView(creatorView, andHLabel: creatorHeadingLbl,andDLabel: creatorDescLbl, selected: false)
        self.creatorName.text = AppCache.shared.currentUser?.user.userName
        descTextView.text = viewModelAddOutfitVM?.requestModel.description
        configLblUI()
    }
    
}
extension PreviewOutfitWithItemsVC{
    
    func uploadOutfit(){
        
        viewModelAddOutfitVM?.uploadOutfit(){[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(_):
                print("Uploaded Successfully")
                let nextVC = ScreenManager.getController(storyboard: .authentication, controller: CompletedSignUpPopUp.self)
                nextVC.viaUploadOutfitProcess = true
                nextVC.modalPresentationStyle = .overCurrentContext
                nextVC.onContinue = { [weak self] in
                    guard let self = self else {return}
                    
                    let nextVC = ScreenManager.getController(storyboard: .home, controller: RoundedTabbarController.self)
                    nextVC.selectedIndex = 0
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                self.navigationController?.present(nextVC, animated: true)
                
                break
            case .failure(let error):
                print(error)
                break
            }
            
        }
        
    }
    
}


// MARK: - DZNEmptyDataSetSource Methods
extension PreviewOutfitWithItemsVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
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
