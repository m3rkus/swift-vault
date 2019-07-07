//
//  ReusableCell.swift
//  swift-vault
//
//  Created by m3rkus on 04/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

extension UITableViewCell: Identifiable { }

public extension UITableView {
    
    func dequeueCell<T: UITableViewCell>(type: T.Type,
                                         indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier,
                                                  for: indexPath) as? T
        else {
            fatalError("Unable to dequeue \(T.self)")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cells: [T.Type],
                                      bundle: Bundle? = nil) {
        
        cells.forEach {
            register(cell: $0,
                     bundle: bundle)
        }
    }
    
    func register<T: UITableViewCell>(cell: T.Type,
                                      bundle: Bundle? = nil) {
        
        self.register(UINib(nibName: T.identifier,
                            bundle: bundle),
                      forCellReuseIdentifier: T.identifier)
    }
}

extension UICollectionViewCell: Identifiable { }

public extension UICollectionView {
    
    func dequeueCell<T: UICollectionViewCell>(type: T.Type,
                                              indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier,
                                                  for: indexPath) as? T
        else {
            fatalError("Unable to dequeue \(T.self)")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(cell: T.Type,
                                           bundle: Bundle? = nil) {
        
        self.register(UINib(nibName: T.identifier,
                            bundle: bundle),
                      forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell>(cells: [T.Type],
                                           bundle: Bundle? = nil) {
        
        cells.forEach {
            register(cell: $0,
                     bundle: bundle)
        }
    }
}
