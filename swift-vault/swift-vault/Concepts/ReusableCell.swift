//
//  ReusableCell.swift
//  swift-vault
//
//  Created by m3rkus on 04/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

extension UITableViewCell: Identifiable { }

extension UITableView {
    
    func dequeueCell<T: UITableViewCell>(type: T.Type,
                                         indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier,
                                                  for: indexPath) as? T
            else {
                fatalError("Unable to dequeue \(T.self)")
        }
        return cell
    }
    
    func registerCell<T: UITableViewCell>(type: T.Type) {
        
        self.register(UINib(nibName: T.identifier, bundle: nil),
                      forCellReuseIdentifier: T.identifier)
    }
}

extension UICollectionViewCell: Identifiable { }

extension UICollectionView {
    
    func dequeueCell<T: UICollectionViewCell>(type: T.Type,
                                              indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier,
                                                  for: indexPath) as? T
            else {
                fatalError("Unable to dequeue \(T.self)")
        }
        return cell
    }
    
    func registerCell<T: UICollectionViewCell>(type: T.Type) {
        
        self.register(UINib(nibName: T.identifier, bundle: nil),
                      forCellWithReuseIdentifier: T.identifier)
    }
}
