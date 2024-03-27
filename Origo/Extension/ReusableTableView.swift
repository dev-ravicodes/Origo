//
//  ReusableTableView.swift
//  Hammer Parking
//
//  Created by yapapp on 10/21/22.
//

import UIKit

class ReusableTableView: NSObject, UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView
    var tableViewData: [Items]
    var didSelectHandler : ((Int)->())?
    var didSelectSettingsHandler : ((Int)->())?

    init(_ tv: UITableView, _ data: [Items]){
        tableViewData = data
        tableView = tv
        super.init()
        tableView.delegate = self
        tableView.dataSource = self

        // Register all of your cells
        tableView.registerNib(CommanTVC.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClassIdentifier: CommanTVC.self)
//        cell.configCell(item: tableViewData[indexPath.row])
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectHandler?(indexPath.row)
        didSelectSettingsHandler?(indexPath.row)
    }
}

struct Items{
    var text = ""
    var image = UIImage()
}
