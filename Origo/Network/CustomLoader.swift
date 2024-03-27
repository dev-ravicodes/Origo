//
//  CustomLoader.swift
//  TimeApp
//
//  Created by Kamaljeet Punia on 04/05/20.
//  Copyright © 2020 Tina. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SnapKit

class CustomLoader {
    
    // MARK: - VARIABLES
    static let shared = CustomLoader()
    private var currentView: UIView?
    private lazy var loadingSubView: UIView = {
        let view = UIView()
        view.cornerRadius = 15
        view.backgroundColor = UIColor.black.withAlphaComponent(0.55)
        let loadingIndicator = NVActivityIndicatorView(frame: .zero, type: .orbit, color: .white, padding: .none)
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(20)
            make.bottom.trailing.equalToSuperview().inset(20)
            make.center.equalToSuperview()
        }
        loadingIndicator.startAnimating()
        return view
    }()
    private var mainWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    // MARK: - CLASS LIFE CYCLE
    private init() {}
    
    // MARK: - PUBLIC FUNCTIONS
    func show() {
        guard let mainView = mainWindow else {
            print("Current screen error")
            return
        }
        hide()
        let subView = UIView()
        subView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        mainView.addSubview(subView)
        mainView.bringSubviewToFront(subView)
        
        subView.snp.makeConstraints { (make) in
            make.edges.equalTo(mainView.safeAreaLayoutGuide)
        }
        
        subView.addSubview(loadingSubView)
        loadingSubView.snp.makeConstraints({ (make) in
            make.width.equalTo(mainView.frame.width*0.2)
            make.height.equalTo(mainView.frame.width*0.2)
            make.center.equalToSuperview()
        })
        
        currentView = subView
    }
    
    func hide() {
        if let currentView = currentView {
            currentView.removeFromSuperview()
            self.currentView = nil
        }
    }
}

