enum Size {
    case small
    case medium
    case large
}

enum Color {
    case red
    case green
    case blue
}

//MARK: Product
struct Product {

    var name: String
    var color: Color
    var size: Size

}

extension Product : CustomStringConvertible {
    var description: String {
        return "\(size) \(color) \(name)"
    }
}

//MARK: Specifications
protocol Specification {
    associatedtype T

    func isSatisfied(item: T) -> Bool
}

struct ProductColorSpecification : Specification {
    typealias T = Product

    var color: Color

    func isSatisfied(item: T) -> Bool {
        return item.color == color
    }
}

struct ProductSizeSpecification : Specification {
    typealias T = Product

    var size: Size

    func isSatisfied(item: T) -> Bool {
        return item.size == size
    }
}

struct AndSpecification<T, SpecA: Specification, SpecB: Specification> : Specification where T == SpecA.T, SpecA.T == SpecB.T {

    var specA: SpecA
    var specB: SpecB

    init(specA: SpecA, specB: SpecB) {
        self.specA = specA
        self.specB = specB
    }

    func isSatisfied(item: T) -> Bool {
        return specA.isSatisfied(item: item) && specB.isSatisfied(item: item)
    }
}

//MARK: Filter
protocol Filter {
    associatedtype T

    func filter<Spec: Specification>(items: [T], specs: Spec) -> [T]
        where Spec.T == T
}

struct GenericFilter<T> : Filter {

    func filter<Spec: Specification>(items: [T], specs: Spec) -> [T]
        where T == Spec.T {
            var output = [T]()
            for item in items {
                if specs.isSatisfied(item: item) {
                    output.append(item)
                }
            }
            return output
    }
}


/// Usage:
let tree = Product(name: "tree", color: .green, size: .large)
let frog = Product(name: "frog", color: .green, size: .small)
let strawberry = Product(name: "strawberry", color: .red, size: .small)

let red = ProductColorSpecification(color: .red)
let small = ProductSizeSpecification(size: .small)
let specs = AndSpecification(specA: red, specB: small)

let result = GenericFilter().filter(items: [tree, frog, strawberry], specs: specs)
print(result)   //  [small red strawberry]
