//
//  Result.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation


// For empty result type use
// func foo() -> Result<Void, Error>
// return Result(value: ())

/// Result abstraction type
enum OldResult<Value, Error: Swift.Error> {
    
    case value(Value)
    case error(Error)
    
    var value: Value? {
        switch self {
        case let .value(value):
            return value
        case .error:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case let .error(error):
            return error
        case .value:
            return nil
        }
    }
    
    var isError: Bool {
        switch self {
        case .error:
            return true
        case .value:
            return false
        }
    }
    
    func resolve() throws -> Value {
        switch self {
        case let .value(value):
            return value
        case let .error(error):
            throw error
        }
    }
    
}

// MARK: - Result without value to provide
extension OldResult where Value == Void {
    static var success: OldResult {
        return .value(())
    }
}

// MARK: StringConvertible
extension OldResult: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        switch self {
        case let .value(value): return ".value(\(value))"
        case let .error(error): return ".error(\(error))"
        }
    }
    
    public var debugDescription: String {
        return description
    }
    
}

// Usage: let user = try result.decoded() as User
extension OldResult where Value == Data {
    
    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        let data = try resolve()
        return try decoder.decode(T.self, from: data)
    }
    
}
