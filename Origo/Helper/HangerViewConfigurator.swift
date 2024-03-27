//
//  HangerViewConfigurator.swift
//  Gutter
//
//  Created by Dev Team on 28/02/23.
//

import UIKit

enum HangarViewConfiguration {
    case none
    case one
    case two
    case three
    case four
    case five
    case six
}

class HangarViewConfigurator {
    static func configureHangarView(with configuration: HangarViewConfiguration, stackViwHangar0: UIView, stackViwHangar1: UIView, stackViwHangar2: UIView, stackViwHangar3: UIView, stackViwHangar4: UIView, stackViwHangar5: UIView) {
        switch configuration {
        case .none:
            stackViwHangar0.isHidden = true
            stackViwHangar1.isHidden = true
            stackViwHangar2.isHidden = true
            stackViwHangar3.isHidden = true
            stackViwHangar4.isHidden = true
            stackViwHangar5.isHidden = true
        case .one:
            stackViwHangar0.isHidden = false
            stackViwHangar1.isHidden = true
            stackViwHangar2.isHidden = true
            stackViwHangar3.isHidden = true
            stackViwHangar4.isHidden = true
            stackViwHangar5.isHidden = true
        case .two:
            stackViwHangar0.isHidden = false
            stackViwHangar1.isHidden = false
            stackViwHangar2.isHidden = true
            stackViwHangar3.isHidden = true
            stackViwHangar4.isHidden = true
            stackViwHangar5.isHidden = true
        case .three:
            stackViwHangar0.isHidden = false
            stackViwHangar1.isHidden = false
            stackViwHangar2.isHidden = false
            stackViwHangar3.isHidden = true
            stackViwHangar4.isHidden = true
            stackViwHangar5.isHidden = true
        case .four:
            stackViwHangar0.isHidden = false
            stackViwHangar1.isHidden = false
            stackViwHangar2.isHidden = false
            stackViwHangar3.isHidden = false
            stackViwHangar4.isHidden = true
            stackViwHangar5.isHidden = true
        case .five:
            stackViwHangar0.isHidden = false
            stackViwHangar1.isHidden = false
            stackViwHangar2.isHidden = false
            stackViwHangar3.isHidden = false
            stackViwHangar4.isHidden = false
            stackViwHangar5.isHidden = true
        case .six:
            stackViwHangar0.isHidden = false
            stackViwHangar1.isHidden = false
            stackViwHangar2.isHidden = false
            stackViwHangar3.isHidden = false
            stackViwHangar4.isHidden = false
            stackViwHangar5.isHidden = false
        }
    }
}
