//
//  TableViewRegisterAndDequeue.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit


extension UITableViewCell: Identifiable {}

extension UITableViewHeaderFooterView: Identifiable {}

extension UITableView {
    
    func dequeueReusableCell<CellClass: UITableViewCell>(of class: CellClass.Type,
                                                         for indexPath: IndexPath,
                                                         configure: ((CellClass) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CellClass.identifier,
                                       for: indexPath)
        if let typedCell = cell as? CellClass {
            configure(typedCell)
        }
        
        return cell
    }
    
    func registerCell<T>(_ cellClass: T) {
        register(UINib(nibName: String(describing: cellClass), bundle: nil),
                 forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func registerHeaderFooter<T>(_ headerFooterClass: T) {
        register(UINib(nibName: String(describing: headerFooterClass), bundle: nil),
                 forHeaderFooterViewReuseIdentifier: String(describing: headerFooterClass))
    }
    
}
