//
//  NavigationControllerCompletion.swift
//  swift-vault
//
//  Created by roman on 12/04/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

/// Add completion block for Navigation Controller push and pop methods
extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)? = nil) {
        
        self.pushViewController(viewController,
                                animated: animated)
        self.callCompletion(animated: animated,
                            completion: completion)
    }
    
    @discardableResult
    func popViewController(animated: Bool,
                           completion: (() -> Void)? = nil) -> UIViewController? {
        
        let viewController = self.popViewController(animated: animated)
        self.callCompletion(animated: animated,
                            completion: completion)
        return viewController
    }
    
    fileprivate func callCompletion(animated: Bool,
                                    completion: (() -> Void)? = nil) {
        
        if animated, let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
}
