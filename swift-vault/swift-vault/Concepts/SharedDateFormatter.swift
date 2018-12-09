//
//  Foo.swift
//  swift-vault
//
//  Created by m3rk on 09/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    class var shared: SharedDateFormatter {
        return SharedDateFormatter.shared
    }
    
}

#warning("add unit tests")
/// DateFormatter is very expensive to create every time when parsing a server response for example
/// so this is a singleton that incapsulates DateFormatter object
final class SharedDateFormatter {
    
    // MARK: - Public Properties
    static let shared = SharedDateFormatter()
    private init() {}
    
    // MARK: - Private Properties
    private struct CacheUnit: Hashable {
        let secondsFromEpoch: TimeInterval
        let format: String
    }
    
    private let dateFormatter = DateFormatter()
    private var cache: [CacheUnit: String] = [:]
    private let cacheSizeLimit = 100
    
}

// MARK: - Public Methods
extension SharedDateFormatter {
    
    func string(from date: Date,
                format: String) -> String {
        
        let cacheUnit = CacheUnit(secondsFromEpoch: date.timeIntervalSince1970,
                                  format: format)
        if let cachedFormattedString = cache[cacheUnit] {
            return cachedFormattedString
        }
        dateFormatter.dateFormat = format
        let formattedString = dateFormatter.string(from: date)
        cache[cacheUnit] = formattedString
        if cache.count > cacheSizeLimit {
            cache.popFirst()
        }
        
        return formattedString
    }
    
    
    
}
