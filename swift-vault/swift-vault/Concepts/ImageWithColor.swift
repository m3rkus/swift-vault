//
//  ImageWithColor.swift
//  swift-vault
//
//  Created by m3rk on 21/04/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(color: UIColor,
                      size: CGSize = .placeholder) {
        
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
