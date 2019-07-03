//
//  Notifications.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

// Usage:
// NotificationCenter.default.post(name: .myNotification, object: nil)
extension Notification.Name {
    
    static let myNotification = Notification.Name("myNotification")
}

extension NotificationCenter {
    
    /// Post notification
    class func post(notification: Notification.Name,
                    object: Any? = nil) {
        
        NotificationCenter.default.post(name: notification,
                                        object: object)
    }
    
    /// Observer notification
    class func observe(notification: Notification.Name,
                       observer: Any,
                       selector: Selector,
                       object: Any? = nil) {
        
        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: notification,
                                               object: object)
    }
    
}
