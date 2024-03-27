//
//  ChangeImagePopUpVC.swift
//  Origo
//
//  Created by iTechnolabs on 22/03/24.
//

import UIKit


class ChangeImagePopUpVC: UIViewController {

    var getBtnIndex : ((Int) -> Void)?
    weak var delegate: CustomCellDelegate?
    var cell = DescribeYourOutfitCell()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    @IBAction func replaceBtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true)
        getBtnIndex?(1)
    }
    
  
     @IBAction func removeBtnAction(_ sender: UIButton) {
         getBtnIndex?(2)
         self.dismiss(animated: true)
     }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
