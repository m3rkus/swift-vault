//
//  StringLocalization.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation


enum Localizable: String, CaseIterable {
    case categories = "categories"
    case fetchingData = "fetching_data"
}

extension String {
    
    /// Localization helper
    /// Usage: label.text = .localized(key: .someText)
    static func localized(key: Localizable,
                          comment: String = "") -> String {
        
        return NSLocalizedString(key.rawValue, comment: comment)
    }
    
    func stringByForcingWritingDirectionLTR() -> String {
        return "\u{200E}".appending(self)
    }
    
    func stringByForcingWritingDirectionRTL() -> String {
        return "\u{200F}".appending(self)
    }
    
}
