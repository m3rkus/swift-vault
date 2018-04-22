// Map mutating alternative

extension Array {

    mutating func mapInPlace(_ transform: (Element) -> Element) {
        self = map(transform)
    }

}
