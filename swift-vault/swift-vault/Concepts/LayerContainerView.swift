//
//  LayerContainerView.swift
//  swift-vault
//
//  Created by m3rk on 12/05/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit


class LayerContainerView: UIView {
    
    override public class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [
            UIColor.blue.cgColor,
            UIColor.cyan.cgColor
        ]
    }
}
