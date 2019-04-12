//
//  ScaledFontSize.swift
//  swift-vault
//
//  Created by roman on 12/04/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

/// Get actual font size for labels with text dynamic scale factor/font size
extension UILabel {
    
    func scaledFontSize(boundsSize: CGSize? = nil) -> CGFloat {
        
        guard let text = text else {
            return 0
        }
        let boundsSize = boundsSize ?? bounds.size
        let attributedString = NSAttributedString(string: text,
                                                  attributes: [.font: font])
        let context = NSStringDrawingContext()
        context.minimumScaleFactor = minimumScaleFactor
        
        attributedString.boundingRect(with: boundsSize,
                                      options: .usesLineFragmentOrigin,
                                      context: context)
        let scaledFontSize = font.pointSize * context.actualScaleFactor
        return scaledFontSize
    }
}
