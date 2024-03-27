//
//  ExploreVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 07/02/24.
//

import UIKit
import Koloda
import DZNEmptyDataSet


class ExploreVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var demoOutfitImgView: UIImageView!
    @IBOutlet weak var koladaView: KolodaView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(ShopOutfitsCVC.self)
            collectionView.emptyDataSetSource = self
        }
    }
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var hangerBtn: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet var creatorName: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(ExpolreItemTVC.self)
        }
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var kolodaViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViw: UIScrollView!
    @IBOutlet weak var noDataCountLbl: UILabel!
    @IBOutlet weak var shopThisOutfitLbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var buyBtnStackTop: NSLayoutConstraint!
    @IBOutlet weak var buyBtnStackBottom: NSLayoutConstraint!
    
    @IBOutlet weak var fraturedItemLbl: UILabel!
    @IBOutlet weak var featuredItemView: UIView!
    
    @IBOutlet weak var featureStackTop: NSLayoutConstraint!
    @IBOutlet weak var itemsTableViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var cretorLbl: UILabel!
    @IBOutlet weak var creatorLblView: UIView!
    @IBOutlet weak var cretorLblTOP: NSLayoutConstraint!
    @IBOutlet weak var descStackTop: NSLayoutConstraint!
    
    //MARK: - Variables
    var viewModel = ProfileVM()
    var hangItViewModel = HangItVM()
    var currentIndex = 0
    var imgIndex = 0
    var showImages = [String]()
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    var animationImg: String?
    var searchFilters = [String]()
    var minRanges = String()
    var maxRanges = String()
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if !AppCache.shared.newUser {
            demoOutfitImgView.isHidden = false
            koladaView.isHidden = true
            let nextVC = ScreenManager.getController(storyboard: .authentication, controller: ShowCaseVC.self)
            nextVC.modalPresentationStyle = .overFullScreen
            nextVC.onDissmiss = { [weak self] in
                self?.demoOutfitImgView.isHidden = true
                self?.koladaView.isHidden = false
            }
            self.navigationController?.present(nextVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
    }
    
    override func viewWillLayoutSubviews() {
        tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    
    //MARK: - Convenience
    func configUI() {
        AppCache.shared.newUser = true
        self.koladaView.delegate = self
        self.koladaView.dataSource = self
        self.koladaView.backgroundCardsScalePercent = 0
        koladaView.alphaValueSemiTransparent = 0.1
        koladaView.countOfVisibleCards = 1
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.prepareOutfitRequestModel()
    }
    
    func configItemsUI() {
        if viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items.count == 0 {
            tableView.isHidden = true
            descTextView.isHidden = true
            shopThisOutfitLbl.isHidden = true
            lineView.isHidden = true
            collectionView.isHidden = true
            buyBtn.isHidden = true
            buyBtnStackTop.constant = 0
            buyBtnStackBottom.constant = 0
            featuredItemView.isHidden = true
            fraturedItemLbl.isHidden = true
            featureStackTop.constant = 0
            cretorLbl.isHidden = true
            creatorLblView.isHidden = true
            cretorLblTOP.constant = 0
            descStackTop.constant = 0
        } else {
            featuredItemView.isHidden = false
            fraturedItemLbl.isHidden = false
            featureStackTop.constant = 60
            cretorLblTOP.constant = 40
            descStackTop.constant = 40
            cretorLbl.isHidden = false
            creatorLblView.isHidden = false
            tableView.isHidden = false
            descTextView.isHidden = false
            shopThisOutfitLbl.isHidden = false
            lineView.isHidden = false
            collectionView.isHidden = false
            buyBtn.isHidden = false
            buyBtnStackTop.constant = 40
            buyBtnStackBottom.constant = 40
        }
    }
    
    func prepareRequestModel(for outfitId: String) {
        hangItViewModel.requestModel.rackId = AppCache.shared.currentUser?.rackID
        hangItViewModel.requestModel.outfitId = outfitId
        self.hangItApi()
    }
    
    func prepareLikeRequestModel(for outfitId: String) {
        hangItViewModel.outfitId = outfitId
        self.likeOutfitApi()
    }
    
    func prepareOutfitRequestModel(search: String? = nil, minRange: String? = nil, maxRange: String? = nil) {
        if search == "" {
            viewModel.outfitRequestModel.search = nil
        } else {
            viewModel.outfitRequestModel.search = search
        }
        viewModel.outfitRequestModel.minRange = minRange
        viewModel.outfitRequestModel.maxRange = maxRange
        getAllusersOutfitsApi()
    }
    
    func animateImageView() {
        let imageView = UIImageView()
        imageView.setImageWithKF(animationImg)
        imageView.frame = CGRect(x: koladaView.center.x, y: koladaView.center.y, width: 50, height: 50)
        view.addSubview(imageView)
        
        // Calculate the destination point (tab bar item's center)
        guard let view = self.tabBarController?.tabBar.items?[1].value(forKey: "view") as? UIView else { return }
        let tabBarCen = view.frame
        
        let centerX = tabBarCen.origin.x + tabBarCen.size.width / 2.4
        
        let tabBarCenter = CGPoint(x: centerX, y: self.view.frame.maxY - 30)
        // Animate the image to move in a curved path towards the tab bar item's position
        let curvedPath = UIBezierPath()
        curvedPath.move(to: imageView.center)
        
        // Adjust the control point to move the image towards the bottom
        let controlPoint = CGPoint(x: (imageView.center.x + tabBarCenter.x) / 2, y: tabBarCenter.y/2)
        curvedPath.addQuadCurve(to: tabBarCenter, controlPoint: controlPoint)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = curvedPath.cgPath
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            imageView.removeFromSuperview()
            // Perform any additional action upon completion of animation
            // For example, update tab bar item to indicate addition
        }
        
        imageView.layer.add(animation, forKey: nil)
        imageView.center = tabBarCenter
        
        CATransaction.commit()
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func moreOptionsAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .home, controller: MoreOptionsVC.self)
        nextVC.onSetting = { [weak self] in
            let nextVC = ScreenManager.getController(storyboard: .profile, controller: ProfileSettingsVC.self)
            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
        nextVC.onPreviousOutfit = { [weak self] in
            self?.koladaView.revertAction(direction: .right)
        }
        nextVC.onReport = { [weak self] in
            let nextVC = ScreenManager.getController(storyboard: .home, controller: ReportOutfitsVC.self)
            nextVC.modalPresentationStyle = .overCurrentContext
            self?.navigationController?.present(nextVC, animated: true)
        }
        nextVC.option = .More
        nextVC.outfitIndex = koladaView.currentCardIndex
        nextVC.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(nextVC, animated: true)
    }
    
    @IBAction func profileAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .profile, controller: ProfileVC.self)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func hangItAction(_ sender: UIButton) {
        self.koladaView.swipe(.right)
        if koladaView.currentCardIndex == viewModel.outfitsResponseModel?.data.data.count {
            return
        }
        let imgIndex = koladaView.currentCardIndex == 0 ? 0 : koladaView.currentCardIndex-1
        let outfitId = viewModel.outfitsResponseModel?.data.data[imgIndex].id ?? ""
        self.prepareRequestModel(for: outfitId)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        self.koladaView.swipe(.left)
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .home, controller: FilterVC.self)
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.onApply = { [weak self] (minRange, maxRange, searchFilter, searchArray) in
            guard let self else { return }
            searchFilters = searchArray
            minRanges = minRange
            maxRanges = maxRange
            prepareOutfitRequestModel(search: searchFilter, minRange: minRange, maxRange: maxRange)
        }
        nextVC.searchFilter = searchFilters
        nextVC.minRange = minRanges
        nextVC.maxRange = maxRanges
        self.navigationController?.present(nextVC, animated: true)
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        let nextVC = ScreenManager.getController(storyboard: .home, controller: ShareVC.self)
        nextVC.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(nextVC, animated: true)
    }
    
    @IBAction func buyAction(_ sender: UIButton) {
        openExternalURL(self.viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items[currentIndex].url ?? "")
    }

       /// Opens the given URL string in the default web browser.
       /// - Parameter urlString: The URL to be opened as a string.
       private func openExternalURL(_ urlString: String) {
           guard let url = URL(string: urlString) else {
               self.showAlertWithText("Invalid URL")
               
               // Optionally, present an alert to the user or handle the error as appropriate.
               return
           }
           
           let application = UIApplication.shared
           if application.canOpenURL(url) {
               application.open(url, options: [:]) { success in
                   if !success {
                       
                       print("Failed to open URL: \(urlString)")
                       // Optionally, present an alert to the user or handle the failure as appropriate.
                   }
               }
           } else {
               print("Cannot open URL: \(urlString)")
               // Optionally, present an alert to the user or handle the situation as appropriate.
           }
       }
    
}


//MARK: - KolodaViewDelegate Methods
extension ExploreVC: KolodaViewDelegate {
    
    func kolodaPanBegan(_ koloda: KolodaView, card: DraggableCardView) {
        feedbackGenerator.impactOccurred()
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koladaView.resetCurrentCardIndex()
        koladaView.reconfigureCards()
        koloda.reloadData()
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.currentIndex = 0
        })
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.currentIndex = 0
        })
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.currentIndex = 0
        })
        self.feedbackGenerator.impactOccurred()
        return true
    }
    
    func kolodaSwipeThresholdRatioMargin(_ koloda: KolodaView) -> CGFloat? {
        return 0.1
    }
    
}

//MARK: KolodaViewDataSource Methods
extension ExploreVC: KolodaViewDataSource {
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return viewModel.outfitsResponseModel?.data.data.count ?? 0
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = CardView()
        let index = viewModel.outfitsResponseModel?.data.data.count ?? 0 <= koloda.currentCardIndex ? 0 : koloda.currentCardIndex
        feedbackGenerator.prepare()
        showImages = viewModel.outfitsResponseModel?.data.data[index].outfitImages ?? [""]
        let imgsCount = showImages.count
        if(imgsCount > imgIndex) {
            let img = showImages[imgIndex]
            if !(img.isBlank) {
                DispatchQueue.main.async {
                    view.cardImage.setImageWithKF(img)
                    view.imgsCount.text = "\(self.imgIndex+1)/\(imgsCount)"
                    self.creatorName.text =  self.viewModel.outfitsResponseModel?.data.data[index].userID.userName ?? ""
                    self.descTextView.text = "\(self.viewModel.outfitsResponseModel?.data.data[index].description.capitalized ?? "")"
                }
            }
        }
        view.leftHandler = { [weak self] in
            guard let self else { return }
            if(imgIndex > 0) {
                imgIndex -= 1
                koladaView.reconfigureCards()
            }
        }
        view.rightHandler = { [weak self] in
            guard let self else {return}
            print(showImages)
            print(imgIndex)
            if(imgIndex<showImages.count-1) {
                imgIndex += 1
                koladaView.reconfigureCards()
            }
            else if imgIndex == showImages.count - 1 {
                imgIndex = 0
                koladaView.reconfigureCards()
            }
        }

        return view
    }
    
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        currentIndex = 0
        collectionView.reloadData()
        if index >= viewModel.outfitsResponseModel?.data.data.count ?? 0 {
            return
        }
        if(koladaView.currentCardIndex != 0) {
            self.koladaView.reloadData()
        }
        self.configItemsUI()
        self.collectionView.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        imgIndex = 0
        var imageIndex = 0
        if direction == .right {
            if koladaView.currentCardIndex == viewModel.outfitsResponseModel?.data.data.count {
                imageIndex = 0
            }
            imageIndex = koladaView.currentCardIndex == 0 ? 0 : koladaView.currentCardIndex - 1
            let outfitId = viewModel.outfitsResponseModel?.data.data[imageIndex].id ?? ""
            self.prepareLikeRequestModel(for: outfitId)
        } else {
            currentIndex = 0
            koladaView.reconfigureCards()
            tableView.reloadData()
        }

    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OutfitOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
    
}


//MARK: - UICollectionViewDataSource & UICollectionViewDelegate Methods
extension ExploreVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return koladaView.currentCardIndex >= viewModel.outfitsResponseModel?.data.data.count ?? 0 ? 0 : viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ShopOutfitsCVC.self, for: indexPath)
        cell.itemLbl.text = "Item \(indexPath.row + 1)"
        cell.configCell(viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        if let arr = viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items{
            for i in arr.indices{
                viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items[i].isSelected = false
            }
            viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items[indexPath.row].isSelected = true
        }
        imgIndex = 0
        //        scrollViw.scrollToTop(animated: true)
        DispatchQueue.main.async{
            self.koladaView.reconfigureCards()
            self.collectionView.reloadData()
            self.currentIndex = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        let cellHeight = collectionView.frame.size.height * 0.85
        
        return CGSize(width: size , height: Int(cellHeight))
    }
    
}


extension ExploreVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if koladaView.currentCardIndex >= viewModel.outfitsResponseModel?.data.data.count ?? 0 {
            return 0
        } else {
            return viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: ExpolreItemTVC.self, for: indexPath)
        cell.configCell(viewModel.outfitsResponseModel?.data.data[koladaView.currentCardIndex].items[indexPath.row])
        
        return cell
    }
    
}


// MARK: - Networking
extension ExploreVC: AlertProtocol {
    private func getAllusersOutfitsApi() {
        CustomLoader.shared.show()
        self.viewModel.getAllUsersOutfitsApi{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.koladaView.reloadData()
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
                self?.noDataCountLbl.isHidden = self?.viewModel.outfitsResponseModel?.data.data.count ?? 0 == 0 ? false : true
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func hangItApi() {
        CustomLoader.shared.show()
        self.hangItViewModel.hangIt{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.koladaView.reloadData()
                self?.collectionView.reloadData()
                //                self?.animateImageView()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func likeOutfitApi() {
        CustomLoader.shared.show()
        self.hangItViewModel.likeOutfit{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.currentIndex = 0
                self?.koladaView.reconfigureCards()
                self?.tableView.reloadData()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}

extension UIScrollView {
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
}


// MARK: - DZNEmptyDataSetSource Methods
extension ExploreVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
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
