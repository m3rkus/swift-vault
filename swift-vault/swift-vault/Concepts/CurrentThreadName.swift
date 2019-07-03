//
//  CurrentThreadName.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

public extension Thread {
    
    /// Returns the name of the thread or 'main-thread', if it's the application's main thread
    class var currentName: String {
        
        guard !isMainThread else { return "main-thread" }
        
        if let threadName = current.name, !threadName.isEmpty {
            return threadName
        } else {
            return String(format: "%p", current)
        }
    }
}
