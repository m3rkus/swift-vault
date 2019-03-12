//
//  CurrentViewController.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit


extension UIApplication {
    
    /// Get current displayed view controller
    class func getCurrentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getCurrentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getCurrentViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getCurrentViewController(base: presented)
        }
        return base
    }
    
}
