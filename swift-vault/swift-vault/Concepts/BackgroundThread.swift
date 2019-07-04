//
//  BackgroundThread.swift
//  swift-vault
//
//  Created by m3rkus on 04/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    /// Performs an operation on a background thread with specified QoS
    static func background(qos: DispatchQoS.QoSClass = .utility,
                           operation: @escaping () -> Void) {
        DispatchQueue.global(qos: qos).async {
            operation()
        }
    }
}
