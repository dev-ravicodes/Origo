//
//  UICollectionViewExtension.swift
//  MyEarthLink
//
//  Created by IOS on 22/06/21.
//  Copyright © 2021 Kamal. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /// Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
    /// Note: withIdentifier must be equal to the Cell Class.
    func dequeueReusableCell<T : UICollectionViewCell>(with cell: T.Type, for indexPath: IndexPath) -> T {
        if let Cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: cell.self), for: indexPath) as? T{
            return Cell
        }
        fatalError(String(describing: cell.self))
    }
    
    func dequeueReusableView<T : UICollectionReusableView>(with view: T.Type, for indexPath: IndexPath, of kind: String) -> T {
        if let reusableView = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: view.self), for: indexPath) as? T {
            return reusableView
        }
        fatalError(String(describing: view.self))
    }
    
    /// Registers a nib object containing a cell with the table view under a specified identifier.
    /// Nib name must be equal to the Cell Class, and the forCellReuseIdentifier must equal to Cell Class as well.
    func registerNib(_ cellClass: UICollectionViewCell.Type) {
        let id = String(describing: cellClass.self)
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forCellWithReuseIdentifier: id)
    }
    
    /// Registers a class for use in creating new table cells.
    /// Note: forCellReuseIdentifier must equal to the Cell Class.
    func register(_ cellClass: Swift.AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass.self))
    }
    
    func registerCollectionResuableView(_ viewClass: UICollectionReusableView.Type, kind: String) {
        let id = String(describing: viewClass.self)
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: id)
    }
    
    public func reloadDataAsync() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
