////
////  CommonPopupVC.swift
////  Origo
////
////  Created by iTechnolabs - 7 on 16/02/24.
////
//
//import UIKit
//
//protocol CommonPopupDelegate: AnyObject{
//    func didTapMenu(_ menu : [String])
//}
//
//class CommonPopupVC: UIViewController {
//    
//    @IBOutlet weak var tableView: UITableView! {
//        didSet {
//            tableView.delegate = self
//            tableView.dataSource = self
//            tableView.register(nib: UINib(nibName: "CommonPopupCell", bundle: nil), withCellClass: CommonPopupCell.self)
//        }
//    }
//    @IBOutlet weak var tableHeight: NSLayoutConstraint!
//    
//    var menu: [String] = []
//    var selectedItems: [String] = []
//    weak var delegate: CommonPopupDelegate?
//    var allowMultipleSelection = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let frame = self.view.safeAreaLayoutGuide.layoutFrame
//        let totalHeight = frame.height - 60 - 90 // total height - (top+bottom space) - (other component's height)
//        if totalHeight <= CGFloat(menu.count*54) {
//            tableHeight.constant = CGFloat(menu.count*54)
//        } else {
//            tableHeight.constant = totalHeight
//        }
//        
//    }
//    
//    @IBAction private func doneAction(_ sender: UIButton) {
//        self.dismiss(animated: true) { [weak self] in
//            self?.delegate?.didTapMenu(self?.selectedItems ?? [])
//        }
//    }
//    
//}
//
//extension CommonPopupVC: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menu.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCell(withClass: CommonPopupCell.self, for: indexPath)
//        cell.selectionStyle = .none
//        cell.checkBtn.isSelected = selectedItems.contains(menu[indexPath.row])
//        cell.labelTitle.text = menu[indexPath.row]
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if allowMultipleSelection {
//            if let firstIndex = self.selectedItems.firstIndex(of: (self.menu[indexPath.row])) {
//                self.selectedItems.remove(at: firstIndex)
//            } else {
//                self.selectedItems.append((self.menu[indexPath.row]))
//            }
//        } else {
//            self.selectedItems = [self.menu[indexPath.row]]
//        }
//        
//        self.tableView.reloadData()
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 54
//    }
//    
//}
//
