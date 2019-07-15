//
//  DependencyContainer.swift
//  swift-vault
//
//  Created by m3rkus on 15/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

final class DependencyContainer {
    
    private init() {}
    static let shared = DependencyContainer()
    
    private var resolveMap: [String: (_ container: DependencyContainer) -> Any] = [:]
    
    func register<T>(_ type: T.Type,
                     resolver: @escaping (_ container: DependencyContainer) -> T) {
        
        resolveMap[String(describing: T.self)] = resolver
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let resolver = resolveMap[String(describing: T.self)]!
        return resolver(self) as! T
    }
}
