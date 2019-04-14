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
/// let someView = UIView {
///     $0.backgroundColor = .green
///     $0.alpha = 1
/// }
protocol InitConfigurable {
    
    init()
}

extension InitConfigurable {
    
    init(configure: (Self) -> Void) {
        
        self.init()
        configure(self)
    }
}

/// Allow init configure all objects from standard library
extension NSObject: InitConfigurable { }
