//
//  ImageWithColor.swift
//  swift-vault
//
//  Created by m3rk on 21/04/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(color: UIColor) {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}
