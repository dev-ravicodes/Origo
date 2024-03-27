//
//  AddToRackVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 15/03/24.
//

import UIKit
import DZNEmptyDataSet

enum AddTo {
    case highlight, rack
}

class AddToRackVC: UIViewController {

    
    @IBOutlet weak var titleImgLbl: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(AddToRackTVC.self)
            tableView.emptyDataSetSource = self
        }
    }
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    var viewModel = HangItVM()
    var rackViewModel = RackVM()
    var profileViewModel = ProfileVM()
    var outfitIds = [String]()
    var onAddToRack: (()->())?
    var addTo : AddTo = .rack


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if addTo == .rack {
            titleLbl.text = "Add To Racks"
            titleImgLbl.isHidden = false
            self.getAllRacksApis()
        } else {
            titleImgLbl.isHidden = true
            titleLbl.text = "Add To Highlights"
            self.getMyHighlights()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewHeight.constant = tableView.contentSize.height + 20
        self.view.layoutIfNeeded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    private func prepareRequestModel(name: String?) {
        if addTo == .rack {
            rackViewModel.requestModel.outfits = outfitIds
            rackViewModel.requestModel.name = name
            self.addToRackApi()
        } else {
            profileViewModel.requestModelHighLight.outfits = outfitIds
            profileViewModel.requestModelHighLight.name = name
            self.addToHighLightApi()
        }

    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

extension AddToRackVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.responseModelAllRacksWithoutPrimary?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: AddToRackTVC.self, for: indexPath)
        cell.configCell(viewModel.responseModelAllRacksWithoutPrimary?.data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.prepareRequestModel(name: viewModel.responseModelAllRacksWithoutPrimary?.data[indexPath.row].name)
    }
    
}


// MARK: - Networking
extension AddToRackVC: AlertProtocol {
    private func getAllRacksApis() {
        CustomLoader.shared.show()
        self.viewModel.gatAllRacksExceptPrimary { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.tableView.reloadData()
                self?.viewDidLayoutSubviews()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func getMyHighlights() {
        CustomLoader.shared.show()
        self.viewModel.getMyHighlights { [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.tableView.reloadData()
                self?.viewDidLayoutSubviews()
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func addToRackApi() {
        CustomLoader.shared.show()
        self.rackViewModel.createRack{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.dismiss(animated: true) {
                    self?.onAddToRack?()
                }
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
    
    private func addToHighLightApi() {
        CustomLoader.shared.show()
        self.profileViewModel.createHighLight{ [weak self] result in
            CustomLoader.shared.hide()
            switch result {
            case .success(_):
                self?.dismiss(animated: true) {
                    self?.onAddToRack?()
                }
                
            case .failure(let error):
                debugPrint(error.message)
                self?.showAlertWithText(error.message)
            }
        }
    }
}


// MARK: - DZNEmptyDataSetSource Methods
extension AddToRackVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
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
