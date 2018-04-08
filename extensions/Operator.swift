
// MARK: - Common elements in two arrays
infix operator &
func  &<T : Equatable>(lhs: [T], rhs: [T]) -> [T] {
    return lhs.filter { rhs.contains($0) }
}
