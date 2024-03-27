//
//  OptionsVC.swift
//  Origo
//
//  Created by iTechnolabs on 15/03/24.
//

import UIKit

enum ShowInfo {
    case DescribeOutfit, ShowInfo
}

class OptionsVC: UIViewController {
    

    @IBOutlet weak var optionsHeadingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.registerNib(OptionTVC.self)
        }
    }
    @IBOutlet weak var smlHeadingLbl: UILabel!
    @IBOutlet weak var categoryTop: NSLayoutConstraint!
    
    
    var optionsArray: [String]?
    var headingLblValue = ""
    var showInfo: ShowInfo = .ShowInfo
    var selectedValue: ((String, Int) -> Void)?
    var categoryTopConstant = 15.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryTop.constant = categoryTopConstant
        smlHeadingLbl.isHidden = showInfo == .ShowInfo ? false : true
        optionsHeadingLbl.text = headingLblValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
}


//MARK: - UITableViewDataSource Methods
extension OptionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: OptionTVC.self, for: indexPath)
        guard let optionsArray = optionsArray else {return UITableViewCell()}
        cell.iBtn.isHidden = showInfo == .ShowInfo ? false : true
        cell.configCell(option: optionsArray[indexPath.row])
        cell.buttonAction = { [weak self] in
             guard let self = self else{return}
            let vc = ScreenManager.getController(storyboard: .authentication, controller: OutfitInfoVC.self)
            vc.viaUploadOutfit = true
            vc.imageName = optionsArray[indexPath.row]
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
           }
        
        return cell
    }
    
}


//MARK: - UITableViewDelegate Methods
extension OptionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let optionsArray = optionsArray else {return}
        selectedValue?(optionsArray[indexPath.row],indexPath.row)
        self.dismiss(animated: true)
    }
    
    
    
}
