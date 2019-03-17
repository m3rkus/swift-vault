//
//  DynamicHeightCollectionView.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 17/03/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

/// Usage: just trigger reloadData and then layoutIfNeeded
class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize){
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        
        return contentSize
    }
}
