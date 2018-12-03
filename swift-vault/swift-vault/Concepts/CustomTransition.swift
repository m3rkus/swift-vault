//
//  CustomTransition.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 03/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

// MARK: - Custom presented VC
class VCYellow: UIViewController {
    var startFrame: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    @IBAction func onBtnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension VCYellow: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorPresent(startFrame: self.startFrame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorDismiss(endFrame: self.startFrame)
    }
}

// MARK: - AnimatorPresent
class AnimatorPresent: NSObject, UIViewControllerAnimatedTransitioning {
    
    let startFrame: CGRect
    
    init(startFrame: CGRect) {
        self.startFrame = startFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let vcTo = transitionContext.viewController(forKey: .to),
            let snapshot = vcTo.view.snapshotView(afterScreenUpdates: true) else {
                return
        }
        
        let vContainer = transitionContext.containerView
        
        vcTo.view.isHidden = true
        vContainer.addSubview(vcTo.view)
        
        snapshot.frame = self.startFrame
        vContainer.addSubview(snapshot)
        
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        snapshot.frame = (transitionContext.finalFrame(for: vcTo))
        }, completion: { success in
            vcTo.view.isHidden = false
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}

// MARK: - AnimatorDismiss
class AnimatorDismiss: NSObject, UIViewControllerAnimatedTransitioning {
    
    let endFrame: CGRect
    
    init(endFrame: CGRect) {
        self.endFrame = endFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let vcTo = transitionContext.viewController(forKey: .to),
            let vcFrom = transitionContext.viewController(forKey: .from),
            let snapshot = vcFrom.view.snapshotView(afterScreenUpdates: true) else {
                return
        }
        
        let vContainer = transitionContext.containerView
        vContainer.addSubview(vcTo.view)
        vContainer.addSubview(snapshot)
        
        vcFrom.view.isHidden = true
        
        UIView.animate(withDuration: 0.3,
                       animations: {
                        snapshot.frame = self.endFrame
        }, completion: { success in
            transitionContext.completeTransition(true)
        })
    }
}
