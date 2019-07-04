//
//  FormattedPriceString.swift
//  swift-vault
//
//  Created by m3rkus on 04/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

extension Decimal {
    
    func formattedPriceString(trimTrailingDecimalZeros: Bool = true,
                              includeCurrency: Bool = true,
                              currency: String) -> String {
        
        if NSDecimalNumber(decimal: self).doubleValue != Double(NSDecimalNumber(decimal: self).intValue) {
            let priceString = String(format: "%.2f",
                                     NSDecimalNumber(decimal: self).doubleValue)
            let normalizedPriceString = trimTrailingDecimalZeros
                ? priceString.stringByTrimmingTrailingDecimalZeros()
                : priceString
            return includeCurrency
                ? "\(normalizedPriceString ) \(currency)"
                : normalizedPriceString
        } else {
            let priceString = String(format: "%i",
                                     NSDecimalNumber(decimal: self).intValue)
            return includeCurrency
                ? "\(priceString) \(currency)"
                : priceString
        }
    }
    
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
