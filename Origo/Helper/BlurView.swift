//
//  BlurView.swift
//  JiuJitsu
//
//  Created by iTechnolabs - 7 on 03/01/24.
//

import UIKit

class BlurEffectView: UIVisualEffectView {
    
    private var animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
    private var intensity: CGFloat = 1.5
    
    init(intensity: CGFloat) {
        self.intensity = intensity
        super.init(effect: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        animator.stopAnimation(true)
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        backgroundColor = .clear
        frame = superview.bounds
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        clipsToBounds = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterFG(_:)),
            name:UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        setUpAnimation()
    }
    
    private func setUpAnimation() {
        animator.stopAnimation(true)
        effect = nil
        
        animator.addAnimations { [weak self] in
            self?.effect = UIBlurEffect(style: .dark)
        }
        animator.fractionComplete = intensity
    }
    
    @objc func appWillEnterFG(_ note: Notification) {
        setUpAnimation()
    }
}
