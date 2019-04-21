//
//  URLSessionResult.swift
//  swift-vault
//
//  Created by m3rk on 21/04/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import Foundation

typealias ResultHandler<T> = (Result<T, Error>) -> Void

// MARK: - URLSession Result hepler
extension URLSession {
    
    func dataTask(with url: URL, completionHandler: @escaping ResultHandler<Data>) {
        
        dataTask(with: url) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.success(data ?? Data()))
            }
        }
    }
}

// MARK: - Result Decodable helper
extension Result where Success == Data {
    
    func decode<T: Decodable>(with decoder: JSONDecoder = .init()) -> Result<T, Error> {
        
        do {
            let data = try get()
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }
}
