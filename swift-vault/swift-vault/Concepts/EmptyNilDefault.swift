//
//  EmptyNilDefault.swift
//  swift-vault
//
//  Created by Roman Anistratenko on 19.01.2020.
//  Copyright © 2020 m3rk edge. All rights reserved.
//

import Foundation

protocol Emptyable {
    
    var isEmpty: Bool { get }
}

infix operator ?=

extension Optional where Wrapped: Emptyable {
    
    static func ?=(value: Wrapped?, defaultValue: Wrapped) -> Wrapped {
        
        guard
            let value = value,
            !value.isEmpty
        else {
            return defaultValue
        }
        return value
    }
}

extension String: Emptyable {}
extension Array: Emptyable {}
extension Dictionary: Emptyable {}
extension Set: Emptyable {}

// Usage:
// let c: String? = nil
// print(c ?= "default")
