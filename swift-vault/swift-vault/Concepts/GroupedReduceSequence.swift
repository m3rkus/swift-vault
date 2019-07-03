//
//  GroupedReduceSequence.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import Foundation

public extension Sequence {
    
    /// Returns the result of combining the elements of the sequence using the given combining closure, grouped by keys
    /// generated using the a grouping closure. The result is a dictionary of type `[K : U]`. An initial value should
    /// be given to be used as initial accumulating value in each group.
    ///
    /// - Parameters:
    ///   - initial: a value to be used as the initial accumulating value in each group.
    ///   - combine: a closure that combines the accumulating value of a group and produces a new accumulating value.
    ///   - groupBy: a closure that produces a key for each element in the sequence.
    /// - Returns: a dictionary containing the final accumulated values for each produced key.
    func groupedReduce<K: Hashable, U>(initial: U,
                                       combine: (U, Iterator.Element) throws -> U,
                                       groupBy: (Iterator.Element) throws -> K) rethrows -> [K : U] {
        var result: [K : U] = [:]
        
        for element in self {
            let key = try groupBy(element)
            result[key] = try combine(result[key] ?? initial, element)
        }
        
        return result
    }
}


// MARK: - groupedReduce usage

struct Person {
    var name: String
    var age: Int
}

extension Person: CustomStringConvertible {
    var description: String {
        return "\(name) - \(age) y.o."
    }
}

func groupReduceDemo() {
    let jhon = Person(name: "John", age: 18)
    let shawn = Person(name: "Shawn", age: 18)
    let monica = Person(name: "Monica", age: 21)
    let roman = Person(name: "Roman", age: 21)
    let alina = Person(name: "Alina", age: 24)
    let persons = [ jhon, alina, monica, shawn, roman ]
    
    let combineByAge: ([Person], Person) -> [Person] = { acc, element in
        return acc + [element]
    }
    let ageKey: (Person) -> Int = { $0.age }
    let groupedByAge: [Int: [Person]] = persons.groupedReduce(initial: [],
                                                              combine: combineByAge,
                                                              groupBy: ageKey)
    print(groupedByAge)
    // [18: [John - 18 y.o., Shawn - 18 y.o.],
    //  24: [Alina - 24 y.o.],
    //  21: [Monica - 21 y.o., Roman - 21 y.o.]]
}

