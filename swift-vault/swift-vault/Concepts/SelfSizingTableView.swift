//
//  SelfSizingTableView.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

// Set maxHeight to specific height, default is screen height
// Don't set auto layout height for tableView, instead set
// instrinsic content size property to 'placeholder' or (0, 0)

final class SelfSizingTableView: UITableView {
    
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    var maxHeightConstraintEnabled = true
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        
        // need it for table with automatic dimension for height enabled cells
        self.layoutIfNeeded()
        
        if maxHeightConstraintEnabled {
            return CGSize(width: contentSize.width,
                          height: min(contentSize.height, maxHeight))
        } else {
            return CGSize(width: contentSize.width,
                          height: contentSize.height)
        }
    }
    
}
