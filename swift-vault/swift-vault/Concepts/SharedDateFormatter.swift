//
//  Foo.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 09/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    class var shared: SharedDateFormatter {
        return SharedDateFormatter.shared
    }
    
}

/// DateFormatter is very expensive to create every time when parsing a server response for example
/// so this is a singleton that incapsulates DateFormatter object
final class SharedDateFormatter {
    
    // MARK: - Public Properties
    static let shared = SharedDateFormatter()
    private init() {}
    
    // MARK: - Private Properties
    private let dateFormatter = DateFormatter()
    
}

// MARK: - Public Methods
extension SharedDateFormatter {
    
    func string(from date: Date,
                format: String) -> String {
        
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}
