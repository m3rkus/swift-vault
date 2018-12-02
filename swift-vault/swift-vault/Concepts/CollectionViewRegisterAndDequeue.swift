//
//  CollectionViewRegisterAndDequeue.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

extension UICollectionReusableView: Identifiable {}

extension UICollectionView {
    
    func dequeueReusableCell<CellClass: UICollectionViewCell>(of class: CellClass.Type,
                                                              for indexPath: IndexPath,
                                                              configure: ((CellClass) -> Void) = { _ in }) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CellClass.identifier,
                                       for: indexPath)
        if let typedCell = cell as? CellClass {
            configure(typedCell)
        }
        
        return cell
    }
    
    func registerCell<T>(_ cellClass: T) {
        register(UINib(nibName: String(describing: cellClass), bundle: nil),
                 forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func registerSectionHeader<T>(_ cellClass: T) {
        register(UINib(nibName: String(describing: cellClass), bundle: nil),
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: cellClass))
    }
    
}
