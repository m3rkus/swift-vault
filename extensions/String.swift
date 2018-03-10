// MARK: - Convenient string indexing

extension String {
    func index(at offset: Int, from start: Index? = nil) -> Index? {
        return index(start ?? startIndex, offsetBy: offset, limitedBy: endIndex)
    }
    func character(at offset: Int) -> Character? {
        precondition(offset >= 0, "offset can't be negative")
        guard let index = index(at: offset) else { return nil }
        return self[index]
    }
    subscript(_ range: CountableRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)]
    }
    subscript(_ range: CountableClosedRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)]
    }
    subscript(_ range: PartialRangeUpTo<Int>) -> Substring {
        return prefix(range.upperBound)
    }
    subscript(_ range: PartialRangeThrough<Int>) -> Substring {
        return prefix(range.upperBound+1)
    }
    subscript(_ range: PartialRangeFrom<Int>) -> Substring {
        return suffix(max(0,count-range.lowerBound))
    }
}

extension Substring {
    var string: String { return String(self) }
}

// Usage:
let test = "Hello USA 🇺🇸!!! Hello Brazil 🇧🇷!!!"
test.character(at: 10)   // "🇺🇸"
test.character(at: 11)   // "!"
test[10...]   // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
test[10..<12]   // "🇺🇸!"
test[10...12]   // "🇺🇸!!"
test[...10]   // "Hello USA 🇺🇸"
test[..<10]   // "Hello USA "
test.first   // "H"
test.last    // "!"
// Note that they all return a Substring of the original String.
// To create a new String you need to add .string as follow
test[10...].string  // "🇺🇸!!! Hello Brazil 🇧🇷!!!"


// MARK: - Helpers
extension String {

    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }

    var containsWhitespace : Bool {
        return self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }

    func trimWhitespaceAndNewLines() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

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
        if(components.count > 0)
        {
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

    func getFirstAndLastNames() -> (firstName: String, lastName: String) {
        let sanitizedString = self.trimWhitespaceAndNewLines()
        let components = sanitizedString.split(separator: .init(" "), maxSplits: 1, omittingEmptySubsequences: true)
        let firstName = String(components.first ?? "")
        let lastName = String(components.count > 1 ? (components.last ?? "") : "")
        return (firstName, lastName)
    }

}
