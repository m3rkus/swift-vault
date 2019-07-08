//
//  TableViewReloadCompletion.swift
//  swift-vault
//
//  Created by m3rkus on 08/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// - Reload data with a completion handler.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}

extension UICollectionView {
    
    /// - Reload data with a completion handler.
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
