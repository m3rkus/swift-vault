//
//  ErrorHandling.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 07/01/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

/// Declare custom errors
enum Errors: Error, LocalizedError {
    
    case emailNotFound
    
    public var errorDescription: String? {
        switch self {
        case .emailNotFound:
            return "Email not found"
        }
    }
    
}
