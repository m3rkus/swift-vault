//
//  ViewController.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foo()
    }

}

final class ServiceLocator {
    
    var fooService: FooServiceProtocol {
        return FooService()
//        return FooServiceMock()
    }
}

final class FooServiceMock: FooServiceProtocol, MockObject {
}

final class FooService: FooServiceProtocol {
}

protocol FooServiceProtocol {
}

protocol MockObject {
}

struct TestModel: Codable {
    
    enum TestEnum: String, Codable {
        case foo = "foo"
        case bar = "bar"
    }
    
    let testEnum:TestEnum
}

func foo() {
    
    let json = """
{
    "testEnum": "foo"
}
""".data(using: .utf8)!
    
    let decoder = JSONDecoder()
    let product = try! decoder.decode(TestModel.self, from: json)
    print(product)
}


