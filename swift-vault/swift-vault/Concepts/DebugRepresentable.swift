//
//  DebugRepresentable.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

/// Convenient printing of model objects
protocol DebugRepresentable {
    var description: [String: Any] { get }
    func dump()
}

extension DebugRepresentable {
    var description: [String: Any] {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        for (labelMaybe, valueMaybe) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }
            if let value = valueMaybe as? DebugRepresentable {
                result[label] = value.description
            } else {
                result[label] = valueMaybe
            }
        }
        return result
    }
    
    func dump() {
        print(String(data: try! JSONSerialization.data(withJSONObject: self.description, options: .prettyPrinted), encoding: .utf8 )!)
    }
}
