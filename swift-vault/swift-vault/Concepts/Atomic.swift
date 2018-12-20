//
//  Atomic.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 20/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

/// Atomic thread-safe wrapper for variables
/// Usage:
/// let x = Atomic<Int>(5)
/// x.mutate { $0 += 1 }
final class Atomic<A> {
    
    private let queue = DispatchQueue(label: "Atomic serial queue")
    private var _value: A
    
    init(_ value: A) {
        self._value = value
    }
    
    var value: A {
        get {
            return queue.sync { self._value }
        }
    }
    
    func mutate(_ transform: (inout A) -> ()) {
        queue.sync {
            transform(&self._value)
        }
    }
    
}
