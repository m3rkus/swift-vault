// MARK: - Group items of array by property
// Usage:
// let jhon = Person(name: "John", age: 18)
// let shawn = Person(name: "Shawn", age: 18)
// let monica = Person(name: "Monica", age: 21)
// let roman = Person(name: "Roman", age: 21)
// let alina = Person(name: "Alina", age: 24)
// let persons = [ jhon, alina, monica, shawn, roman ]
// let groupedPersons = persons.group { $0.age }

extension Sequence {

    func group<T: Hashable>(by key: (Iterator.Element) -> T) -> [[Iterator.Element]] {
        var groups: [T: [Iterator.Element]] = [:]
        var groupsOrder: [T] = []
        forEach { element in
            let key = key(element)
            if case nil = groups[key]?.append(element) {
                groups[key] = [element]
                groupsOrder.append(key)
            }
        }
        return groupsOrder.map { groups[$0]! }
    }

}
