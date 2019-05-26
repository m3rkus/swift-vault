//
//  isBlankString.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

/// String validation for a blank string (detect
/// empty string or string containing whitespaces characters)
/*
"Hello".isBlank        // false
"   Hello   ".isBlank  // false
"".isBlank             // true
" ".isBlank            // true
"\t\r\n".isBlank       // true
"\u{00a0}".isBlank     // true
"\u{2002}".isBlank     // true
"\u{2003}".isBlank     // true
*/

extension String {
    
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}

extension Optional where Wrapped == String {
    
    var isBlank: Bool {
        return self?.isBlank ?? true
    }
}
