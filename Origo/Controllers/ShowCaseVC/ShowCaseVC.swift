//
//  ShowCaseVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 22/02/24.
//

import UIKit


class ShowCaseVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var guideLbl: UILabel!
    @IBOutlet weak var guideImg: UIImageView!
    @IBOutlet weak var guideDetailLbl: UILabel!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgBgCircle: UIView!
    @IBOutlet weak var imageViewTop: NSLayoutConstraint!
    
    
    //MARK: - Variables
    var tapGesture = UITapGestureRecognizer()
    var onDissmiss: (()->())?
    
    
    //MARK: - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tapGesture.view?.tag = 1
    }
    
    
    //MARK: - Convenience
    private func configUI() {
        addGifImage(for: Gif.ic_SwipeRight.rawValue, speedUp: false)
        imageViewHeight.constant = 50
        tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showGuideneceUI(tapGesture:)))
        self.view.addGestureRecognizer(tapGesture)
        self.attributedText()
    }
    
    private func addGifImage(for gif: String, speedUp: Bool = false){
        let animatedImage = UIImage.gifImageWithName(gif)
        guideImg.animationImages = animatedImage?.images
        guideImg.animationDuration = speedUp == true ? (animatedImage?.duration)! / 16 : (animatedImage?.duration)! / 6
        guideImg.startAnimating()
    }
    
    private func attributedText() {
        let attributedString = NSMutableAttributedString(string: "to save your favorite outfits to My Rack")
        let range1 = (attributedString.string as NSString).range(of: "My Rack")
        attributedString.addAttribute(.foregroundColor, value: UIColor.accountTypeBg, range: range1)
        attributedString.addAttribute(.font, value: UIFont.urbanistBold(ofSize: 30), range: range1)
        guideDetailLbl.attributedText = attributedString
    }
    
    
    //MARK: - Objc Methods
    @objc func showGuideneceUI(tapGesture: UITapGestureRecognizer) {
        if tapGesture.view?.tag == 0 {
            tapGesture.view?.tag = 1
            guideLbl.text = "Swipe right to like"
            guideDetailLbl.isHidden = true
            imgBgCircle.isHidden = true
        }
        else if tapGesture.view?.tag == 1 {
            tapGesture.view?.tag = 2
            guideLbl.text = "Press Hang It"
            imageViewHeight.constant = 100
            imageViewTop.constant = 4
            imgBgCircle.isHidden = false
            self.addGifImage(for: Gif.ic_Hanger.rawValue, speedUp: true)
            guideDetailLbl.isHidden = false
        }  else if tapGesture.view?.tag == 2 {
            guideLbl.text = "Swipe left to pass"
            imageViewTop.constant = -10
            imageViewHeight.constant = 88
            self.addGifImage(for: Gif.ic_SwipeLeft.rawValue, speedUp: false)
            guideDetailLbl.isHidden = true
            imgBgCircle.isHidden = true
            tapGesture.view?.tag = 3
        }
        else if tapGesture.view?.tag == 3 {
            guideLbl.text = "or press Next"
            imageViewHeight.constant = 50
            imageViewTop.constant = 8
            self.addGifImage(for: Gif.ic_Next.rawValue, speedUp: true)
            guideDetailLbl.isHidden = true
            imgBgCircle.isHidden = true
            tapGesture.view?.tag = 4
        } else if tapGesture.view?.tag == 4 {
            guideLbl.text = "Scroll up to see more info on the outfit"
            imageViewHeight.constant = 100
            imageViewTop.constant = 4
            self.addGifImage(for: Gif.ic_ScrollUp.rawValue, speedUp: false)
            guideDetailLbl.isHidden = true
            imgBgCircle.isHidden = true
            tapGesture.view?.tag = 5
        }
        else {
            self.dismiss(animated: true) {
                self.onDissmiss?()
            }
            
        }
    }
    
}
