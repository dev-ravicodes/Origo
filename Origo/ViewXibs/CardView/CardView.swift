//
//  CardView.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 21/02/24.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var imgsCount: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    var rightHandler:(()->())?
    var leftHandler:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    func loadViewFromNib() {
        let view = UINib(nibName: "CardView", bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.backgroundColor = UIColor.clear
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        self.rightHandler?()
    }
    
    @IBAction func leftAction(_ sender: UIButton) {
        self.leftHandler?()
    }
    
}
