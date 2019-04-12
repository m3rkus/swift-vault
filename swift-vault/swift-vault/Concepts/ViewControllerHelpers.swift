//
//  ViewControllerHelpers.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

// MARK: - Keyboard
extension UIViewController {
    
    func closeKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - Navigation
extension UIViewController {
    
    var canPop: Bool {
        
        guard let navigationController = parent as? UINavigationController,
              !navigationController.viewControllers.isEmpty
        else {
            return false
        }
        return navigationController.viewControllers.first != self
    }
    
    var isModal: Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    
    func closeScreen(animated: Bool = true,
                     completion: (() -> Void)? = nil) {
        
        closeKeyboard()
        
        if isModal || !canPop {
            self.dismiss(animated: animated,
                         completion: completion)
        } else {
            navigationController?.popViewController(animated: animated,
                                                    completion: completion)
        }
    }
}

// MARK: - Storyboard helpers
extension UIViewController {
    
    class func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: String(describing: self))
    }
    
    class func instantiateFromStoryboard(storyboardName: String) -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: storyboardName)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T {
        let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboad.instantiateViewController(withIdentifier: storyboardName) as! T
        
        return controller
    }
    
}

// MARK: - Child VC Management
extension UIViewController {
    
    func embed(_ child: UIViewController,
               into parentView: UIView) {
        
        addChild(child)
        parentView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func unembed() {
        
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
