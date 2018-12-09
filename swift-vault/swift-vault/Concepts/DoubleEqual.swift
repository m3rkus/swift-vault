//
//  DoubleEqual.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

extension Double {
    
    func doubleEqual(_ a: Double, _ b: Double) -> Bool {
        return fabs(a - b) < .ulpOfOne
    }
    
}
