//
//  Identifiable.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

public protocol Identifiable {
    
    static var identifier: String { get }
}

public extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
}
