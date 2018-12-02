//
//  NilOrEmpty.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

// MARK: - For optional string validation
// Usage:
// guard !usernameTextField.text.isNilOrEmpty else { return false }

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
