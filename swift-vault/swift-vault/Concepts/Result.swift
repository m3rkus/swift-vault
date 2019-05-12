//
//  Result.swift
//  swift-vault
//
//  Created by m3rk on 12/05/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

extension Result {
    
    var isSuccess: Bool {
        
        if case .success(_) = self {
            return true
        }
        return false
    }
    
    var isFailure: Bool {
        
        if case .failure(_) = self {
            return true
        }
        return false
    }
    
}

extension Result: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        switch self {
        case let .success(value): return ".value(\(value))"
        case let .failure(error): return ".error(\(error))"
        }
    }
    
    public var debugDescription: String {
        return description
    }
    
}

// Usage: let user = try result.decoded() as User
extension Result where Success == Data {
    
    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        let data = try get()
        return try decoder.decode(T.self, from: data)
    }
    
}
