//
//  LabelTextInsets.swift
//  swift-vault
//
//  Created by Роман Анистратенко on 16/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    var textInsets: UIEdgeInsets = .zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    // MARK: - Text Insets
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override func textRect(forBounds bounds: CGRect,
                           limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
}
