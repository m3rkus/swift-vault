//
//  OptionalOr.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 11/03/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

extension Optional {
    
    /// Usage: let gift = try g.or(ServerError(privateMessage: "No such gift"))
    func or(_ err: Error) throws -> Wrapped {
        
        guard let value = self else {
            throw err
        }
        return value
    }
    
}
