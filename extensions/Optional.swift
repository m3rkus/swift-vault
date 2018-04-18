
// MARK: - For optional string validation
// Usage: 
// guard !usernameTextField.text.isNilOrEmpty else { return false }

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case let string?:
            return string.isEmpty
        case nil:
            return true
        }
    }
}
