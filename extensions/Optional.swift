
// MARK: - For optional string validation
// Usage: 
// guard !usernameTextField.text.isNilOrEmpty else { return false }

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}


// MARK: - For optional values closure based matching
// Usage: 
// searchBar.text.matching { $0.count > 2 }.map(performSearch)
extension Optional {
    func matching(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let value = self else {
            return nil
        }

        guard predicate(value) else {
            return nil
        }

        return value
    }
}