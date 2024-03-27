//
//  FilterVC.swift
//  Origo
//
//  Created by iTechnolabs - 7 on 29/02/24.
//

import UIKit
import RangeSeekSlider


class FilterVC: UIViewController {
    
    @IBOutlet weak var sliderView: RangeSeekSlider!
    @IBOutlet weak var springButton: UIButton!
    @IBOutlet weak var winterButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    

    var onApply: ((_ minRange: String, _ maxRange: String, _ searchFilter: String, _ searchArray: [String] )->())?
    var searchFilter = [String]()
    var minRange = String()
    var maxRange = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    private func configUI() {
        sliderView.labelPadding = -56
        sliderView.maxLabelFont = UIFont.urbanistSemiBold(ofSize: 14)
        sliderView.minLabelFont = UIFont.urbanistSemiBold(ofSize: 14)
        sliderView.minValue = 1
        sliderView.maxValue = 5
        if let doubleValue = Double(minRange) {
            sliderView.selectedMinValue = CGFloat(doubleValue)
        }
        if let doubleValue = Double(maxRange) {
            sliderView.selectedMaxValue = CGFloat(doubleValue)
        }
        if searchFilter.contains("Spring/Summer") {
            springButton.backgroundColor = .accountTypeBg
            springButton.setTitleColor(.white, for: .normal)
        } else {

            springButton.backgroundColor = .white
            springButton.setTitleColor(.buttonBGColor, for: .normal)
        }
        if searchFilter.contains("Fall/Winter") {
            winterButton.backgroundColor = .accountTypeBg
            winterButton.setTitleColor(.white, for: .normal)
        } else {

            winterButton.backgroundColor = .white
            winterButton.setTitleColor(.buttonBGColor, for: .normal)
        }
        sliderView.delegate = self
        minRange = "\((Int(sliderView.minValue)))"
        maxRange = "\((Int(sliderView.maxValue)))"
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func showInfoAction(_ sender: UIButton) {
        let vc = ScreenManager.getController(storyboard: .authentication, controller: OutfitInfoVC.self)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @IBAction func springButtonAction(_ sender: UIButton) {
        if searchFilter.contains("Spring/Summer") {
            if let index = searchFilter.firstIndex(of: "Spring/Summer") {
                searchFilter.remove(at: index)
            }
            springButton.backgroundColor = .white
            springButton.setTitleColor(.buttonBGColor, for: .normal)
        } else {
            searchFilter.append("Spring/Summer")
            springButton.backgroundColor = .accountTypeBg
            springButton.setTitleColor(.white, for: .normal)
        }

    }
    
    @IBAction func winterButtonAction(_ sender: UIButton) {
        if searchFilter.contains("Fall/Winter") {
            if let index = searchFilter.firstIndex(of: "Fall/Winter") {
                searchFilter.remove(at: index)
            }
            winterButton.backgroundColor = .white
            winterButton.setTitleColor(.buttonBGColor, for: .normal)
        } else {
            searchFilter.append("Fall/Winter")
            winterButton.backgroundColor = .accountTypeBg
            winterButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
//        if !(spring).isBlank {
//            self.searchFilter.append(spring)
//        }
//        if !(winter).isBlank {
//            self.searchFilter.append(winter)
//        }
        let combinedFilters = searchFilter.joined(separator: ", ")
        self.dismiss(animated: true) {
            self.onApply?(self.minRange ?? "", self.maxRange ?? "", combinedFilters, self.searchFilter)
        }
    }
    
}


// MARK: - RangeSeekSliderDelegate
extension FilterVC: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        minRange = "\((Int(minValue)))"
        maxRange = "\((Int(maxValue)))"
    }
}
