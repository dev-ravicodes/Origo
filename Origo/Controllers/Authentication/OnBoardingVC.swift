//
//  OnBoardingVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 02/02/24.
//

import UIKit
import AdvancedPageControl

struct WelcomeData {
    var itemImage: String
    var itemDesc: String
    var itemNameImage: String
}

class OnBoardingVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var pageCollectionView: UICollectionView! {
        didSet {
            pageCollectionView.delegate = self
            pageCollectionView.dataSource = self
            pageCollectionView.registerNib(OnBoardingCVC.self)
            pageCollectionView.registerNib(OnBoardingTopCReatorsCVC.self)
        }
    }
    @IBOutlet weak var signUPBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var pageControllImgView: UIImageView!
    
    
    //MARK: - Variables
    var items: [WelcomeData] = []
    private var isBackButtonHidden: Bool = true {
        didSet {
            backBtn.isHidden = isBackButtonHidden
        }
    }
    var viewModel = TopCreatorsVM()
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
    }
    
    
    //MARK: - Convenience
    private func configView() {
        pageCollectionView.addObserver(self, forKeyPath: "contentOffset", options: [.new], context: nil)
        items.append(WelcomeData(itemImage: "ic_birthplaceIcon", itemDesc: "Origo is the birthplace of fashion trends. Get ready to inspire and get inspired by thousands of outfits.", itemNameImage: "ic_ExploreIcon"))
        items.append(WelcomeData(itemImage: "ic_hangerIcon", itemDesc: "My Rack", itemNameImage: "ic_MyRockIcon"))
        items.append(WelcomeData(itemImage: "ic_unleash", itemDesc: "Unleash your creativity and become a trend setter. With Origo, posting an outfit has never been easier! ", itemNameImage: "ic_FItCheckIcon"))
        items.append(WelcomeData(itemImage: "ic_sendIcon", itemDesc: "Send outfits you like or personal fit checks to your friends. Exchange ideas and discuss fashion creations.", itemNameImage: "ic_InboxIcon"))
        items.append(WelcomeData(itemImage: "", itemDesc: "Climb or navigate the rankings of the top creators, brands and fashion outfits of the moment.", itemNameImage: "ic_RankingsIcon"))
        self.getTopCreatorsApi()
    }
    
    
    deinit {
        pageCollectionView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    private func updatePageControlImages(index: Int) {
        
    }
    
    
    private func scrollToPage(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func getCurrentPageIndex() -> Int {
        let currentPage = pageCollectionView.contentOffset.x / pageCollectionView.bounds.width
        
        return Int(currentPage)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            if let collectionView = object as? UICollectionView {
                let currentPage = round(collectionView.contentOffset.x / collectionView.bounds.width)
                isBackButtonHidden = currentPage <= 0
            }
        }
    }
    
    private func configControlImg(_ iconImage: UIImage?) {
        if #available(iOS 15.0, *) {
            iconImage?.prepareForDisplay { [weak self] preparedImage in
                DispatchQueue.main.async {
                    self?.pageControllImgView.image = preparedImage
                }}
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    //MARK: - Interface Builder Actions
    @IBAction func backAction(_ sender: UIButton) {
        let currentIndex = getCurrentPageIndex()
        let previousIndex = max(0, currentIndex - 1)
        scrollToPage(index: previousIndex)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        let currentIndex = getCurrentPageIndex()
        if currentIndex >= 4 {
            let nextVC = ScreenManager.getController(storyboard: .onboarding, controller: FitsTasteVC.self)
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let nextIndex = min(items.count - 1, currentIndex + 1)
            scrollToPage(index: nextIndex)
        }
        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        //        let nextVC = ScreenManager.getController(storyboard: .main, controller: LoginVC.self)
        //        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    //MARK: - UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: OnBoardingCVC.self, for: indexPath)
        let creatorsCell = collectionView.dequeueReusableCell(with: OnBoardingTopCReatorsCVC.self, for: indexPath)
        if indexPath.item != 4 {
            cell.configData(items[indexPath.row])
            
            return cell
        } else {
            creatorsCell.configData(items[indexPath.row])
            creatorsCell.item = viewModel.responseModel?.data
            
            return creatorsCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width
        let height = collectionView.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let index = (offSet / width)
        if index == 0 {
            configControlImg(UIImage(named: "ic_exploreControlIcon"))
        } else if index == 1 || index == 2 || index == 3 {
            configControlImg(UIImage(named: "ic_middleControllIcon"))
        } else {
            configControlImg(UIImage(named: "ic_RannkingsControllIcon"))
        }
    }
    
}


// MARK: - Networking
extension OnBoardingVC: AlertProtocol {
    private func getTopCreatorsApi() {
        CustomLoader.shared.show()
        self.viewModel.getTopCreators { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_): break
                
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
}
