//
//  CompletedSignUpPopUp.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 01/02/24.
//

import UIKit

class CompletedSignUpPopUp: UIViewController {
    
    @IBOutlet weak var buttonOfRedirection: CustomButton!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var viaUploadOutfitProcess = false
    var onContinue: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        if viaUploadOutfitProcess{
            headingLbl.text = "Alright! Your outfit was successfully posted!"
            buttonOfRedirection.setTitle("Redirect to Home", for: .normal)
        }
        let animatedImage = UIImage.gifImageWithName("ic_signUpSuccess")
        imgView.animationImages = animatedImage?.images
        imgView.animationDuration = (animatedImage?.duration)! / 4
        imgView.startAnimating()
    }
        
    @IBAction func contiueAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: self.onContinue)
    }

}
