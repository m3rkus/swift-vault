//
//  MapInPlace.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

extension Array {
    
    /// Map mutating alternative
    mutating func mapInPlace(_ transform: (Element) -> Element) {
        self = map(transform)
    }
    
}
