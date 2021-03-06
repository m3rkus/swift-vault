//
//  StringHelpers.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Regex
    
    /// Scan string with regex pattern
    func scan(regexPattern: String,
              regexOptions: NSRegularExpression.Options = [],
              regexMatchingOptions: NSRegularExpression.MatchingOptions = []) -> [NSTextCheckingResult] {
        
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: regexPattern,
                                            options: regexOptions)
        } catch {
            print("\(error.localizedDescription)")
            return []
        }
        return regex.matches(in: self,
                             options: regexMatchingOptions,
                             range: NSRange(location: 0,
                                            length: self.utf16.count))
    }
    
    /// Match regex pattern to string
    func match(regex: String,
               options: NSRegularExpression.Options = []) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex,
                                                options: options)
            return regex.firstMatch(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    // MARK: - Formatting
    
    static func formattedSum(currencyId: String? = nil, sum: Double?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        let number = NSNumber(value: (sum ?? 0) / 100)
        if let currencyId = currencyId {
            numberFormatter.numberStyle = .currency
            numberFormatter.currencyCode = currencyId
            numberFormatter.minimumIntegerDigits = 1
            numberFormatter.minimumFractionDigits = 2
            return numberFormatter.string(from: number) ?? ""
        } else {
            numberFormatter.minimumIntegerDigits = 1
            numberFormatter.minimumFractionDigits = 2
            return numberFormatter.string(from: number) ?? ""
        }
    }
    
    func doubleValue(wholeRepresentation: Bool) -> Double {
        let numberFormatter = NumberFormatter()
        let number = (numberFormatter.number(from: self) ?? 0)
        let double = wholeRepresentation ? number.doubleValue * 100 : number.doubleValue
        return double
    }
    
    func intValue(defaultValue: NSNumber = 0) -> Int {
        let numberFormatter = NumberFormatter()
        let number = (numberFormatter.number(from: self) ?? defaultValue)
        return number.intValue
    }
    
    func getInitialsString() -> String? {
        guard isEmpty == false else { return nil }
        var components = self.components(separatedBy: " ").filter({$0 != ""})
        if(components.count > 0) {
            let firstNamePart = components.removeFirst()
            let firstInitial = firstNamePart.index(firstNamePart.startIndex, offsetBy: 0)
            if components.count > 0 {
                let secondNamePart = components.joined(separator: " ")
                let secondInitial = secondNamePart.index(secondNamePart.startIndex, offsetBy: 0)
                return "\(firstNamePart[firstInitial])\(secondNamePart[secondInitial])".uppercased()
            }
            return "\(firstNamePart[firstInitial])".uppercased()
        }
        return nil
    }

    // MARK: - Trimming
    
    func stringByTrimmingTrailingDecimalZeros() -> String {
        var result = self
        return result.trimTrailingDecimalZeros()
    }
    
    @discardableResult private mutating func trimTrailingDecimalZeros() -> String {
        while self.last == "0" {
            self = String(self[..<index(endIndex, offsetBy: -1)])
        }
        // if we got the decimal point (for example 12.00), trim that as well
        if self.last == "." || self.last == "," {
            self = String(self[..<index(endIndex, offsetBy: -1)])
        }
        return self
    }
    
    func stringByTrimmingWhitespaceAndNewLines() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
