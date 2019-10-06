//
//  InitConfigurable.swift
//  swift-vault
//
//  Created by m3rk on 14/04/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

/// Protocol for clean object configuration
/// Usage:
/// let label = UILabel().with {
///     $0.textColor = .white
///     $0.alpha = 1
/// }

protocol ObjectConfigurable {}

extension ObjectConfigurable {
    
    @discardableResult
    func with(_ callback: (Self) -> Void) -> Self {
        callback(self)
        return self
    }
}

/// Allow init configure all objects from standard library
extension NSObject: ObjectConfigurable { }
