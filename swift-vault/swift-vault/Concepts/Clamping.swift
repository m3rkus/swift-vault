//
//  Clamping.swift
//  swift-vault
//
//  Created by Roman Anistratenko on 26.05.2020.
//  Copyright © 2020 m3rk edge. All rights reserved.
//

import Foundation

/// Automatically “clamps” out-of-bound values within the prescribed range
/// Usage: @Clamping(initialValue: 0, 0...1) var foo: Int
@propertyWrapper
struct Clamping<Value: Comparable> {
    var value: Value
    let range: ClosedRange<Value>

    init(initialValue value: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(value))
        self.value = value
        self.range = range
    }

    var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
}
