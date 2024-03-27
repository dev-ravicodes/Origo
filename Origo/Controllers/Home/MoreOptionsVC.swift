//
//  MoreOptionsVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 29/02/24.
//

import UIKit

enum MoreOptions: String {
    case setings = "Go to settings"
    case back = "Go back to previous outfit"
    case report = "Report outfit"
}

enum RackOptions: String {
    case rename  = "Rename"
    case hide = "Hide"
    case removeOutfit = "Add or Remove Outfits"
    case remove = "Remove"
}

enum Option {
    case More, Rack
}

class MoreOptionsVC: UIViewController {
    
    
    //MARK: - Interface Builder Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(MoreOptionsTVC.self)
        }
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    //MARK: - Variables
    var info = [Options]()
    //    var racks = [RackOptions]()
    var outfitIndex = Int()
    var onSetting: (()->())?
    var onPreviousOutfit: (()->())?
    var onReport: (()->())?
    var option: Option = .More
    var onRename: (()->())?
    var onHide: (()->())?
    var onRemoveOutfit: (()->())?
    var onRemove: (()->())?

    
    //MARK: - View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if option == .More {
            info.append(Options(image: "ic_setting", title: MoreOptions.setings.rawValue))
            info.append(Options(image: "ic_optionsBack", title: MoreOptions.back.rawValue))
            info.append(Options(image: "ic_Remove_light", title: MoreOptions.report.rawValue))
        }
        else {
            info.append(Options(image: "ic_rackediticon", title: RackOptions.rename.rawValue))
//            info.append(Options(image: "ic_rackhidden", title: RackOptions.hide.rawValue))
            info.append(Options(image: "ic_rackremove", title: RackOptions.removeOutfit.rawValue))
            info.append(Options(image: "ic_removeIcon", title: RackOptions.remove.rawValue))
        }
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                self.dismiss(animated: true)
            }
        }
    }
    
    func prepareRequestModel() {
        
    }
}


//MARK: - UITableViewDataSource & UITableViewDelegate Methods
extension MoreOptionsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: MoreOptionsTVC.self, for: indexPath)
        let lastRowIndex = tableView.numberOfRows(inSection: tableView.numberOfSections-1)
        if (indexPath.row == lastRowIndex - 1) {
            cell.titleLbl.textColor = .red
        }
        
        cell.configCell(info[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if option == .More {
            if indexPath.row == 0 {
                self.dismiss(animated: true) {
                    self.onSetting?()
                }
            }
            else if indexPath.row == 1 {
                if outfitIndex != 0 {
                    self.dismiss(animated: true) {
                        self.onPreviousOutfit?()
                    }
                }
            }
            else {
                self.dismiss(animated: true) {
                    self.onReport?()
                }
            }
        } else {
           if indexPath.row == 0 {
                self.dismiss(animated: true) {
                    self.onRename?()
                }
            }
//          else if indexPath.row == 1 {
//                self.dismiss(animated: true) {
//                    self.onHide?()
//                }
//            }
            else if indexPath.row == 1 {
                self.dismiss(animated: true) {
                    self.onRemoveOutfit?()
                }
            }
           else if indexPath.row == 2 {
                self.dismiss(animated: true) {
                    self.onRemove?()
                }
            }
        }

    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
