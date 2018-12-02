//
//  StringRange.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

extension String {
    
    func index(at offset: Int, from start: Index? = nil) -> Index? {
        return index(start ?? startIndex, offsetBy: offset, limitedBy: endIndex)
    }
    
    func character(at offset: Int) -> Character? {
        precondition(offset >= 0, "offset can't be negative")
        guard let index = index(at: offset) else { return nil }
        return self[index]
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)].string
    }
    
    subscript(_ range: CountableClosedRange<Int>) -> String {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)].string
    }
    
    subscript(_ range: PartialRangeUpTo<Int>) -> String {
        return prefix(range.upperBound).string
    }
    
    subscript(_ range: PartialRangeThrough<Int>) -> String {
        return prefix(range.upperBound+1).string
    }
    
    subscript(_ range: PartialRangeFrom<Int>) -> String {
        return suffix(max(0,count-range.lowerBound)).string
    }
    
}

extension Substring {
    var string: String { return String(self) }
}

func stringRangeDemo() {
    let test = "Hello USA 🇺🇸!!! Hello Brazil 🇧🇷!!!"
    print(test)
    print(test.character(at: 10) ?? "")  // "🇺🇸"
    print(test.character(at: 11) ?? "")   // "!"
    print(test[10...])   // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
    print(test[10..<12])   // "🇺🇸!"
    print(test[10...12])   // "🇺🇸!!"
    print(test[...10])   // "Hello USA 🇺🇸"
    print(test[..<10])   // "Hello USA "
    print(test.first ?? "")   // "H"
    print(test.last ?? "")    // "!"
}
