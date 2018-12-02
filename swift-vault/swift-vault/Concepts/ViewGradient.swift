//
//  ViewGradient.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: - Public
    public typealias GradientVector = (startPoint: CGPoint, endPoint: CGPoint)
    
    public enum GradientDirection {
        
        case leftRight
        case rightLeft
        case topBottom
        case bottomTop
        case topLeftBottomRight
        case bottomRightTopLeft
        case topRightBottomLeft
        case bottomLeftTopRight
        
        var vector: GradientVector {
            switch self {
            case .leftRight:
                return (startPoint: CGPoint(x: 0, y: 0.5),
                        endPoint: CGPoint(x: 1, y: 0.5))
            case .rightLeft:
                return (startPoint: CGPoint(x: 1, y: 0.5),
                        endPoint: CGPoint(x: 0, y: 0.5))
            case .topBottom:
                return (startPoint: CGPoint(x: 0.5, y: 0),
                        endPoint: CGPoint(x: 0.5, y: 1))
            case .bottomTop:
                return (startPoint: CGPoint(x: 0.5, y: 1),
                        endPoint: CGPoint(x: 0.5, y: 0))
            case .topLeftBottomRight:
                return (startPoint: CGPoint(x: 0, y: 0),
                        endPoint: CGPoint(x: 1, y: 1))
            case .bottomRightTopLeft:
                return (startPoint: CGPoint(x: 1, y: 1),
                        endPoint: CGPoint(x: 0, y: 0))
            case .topRightBottomLeft:
                return (startPoint: CGPoint(x: 1, y: 0),
                        endPoint: CGPoint(x: 0, y: 1))
            case .bottomLeftTopRight:
                return (startPoint: CGPoint(x: 0, y: 1),
                        endPoint: CGPoint(x: 1, y: 0))
            }
        }
    }
    
    public func addGradientBackground(firstColor: UIColor,
                                      secondColor: UIColor,
                                      direction: GradientDirection) {
        var gLayer: CAGradientLayer
        
        if let layer = gradientLayer {
            gLayer = layer
        } else {
            gLayer = CAGradientLayer()
            gLayer.name = gradientLayerName
            self.layer.insertSublayer(gLayer, at: 0)
        }
        
        gLayer.frame = bounds
        gLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gLayer.startPoint = direction.vector.startPoint
        gLayer.endPoint = direction.vector.endPoint
    }
    
    public func removeGradientBackground() {
        gradientLayer?.removeFromSuperlayer()
    }
    
    // MARK: - Private
    fileprivate var gradientLayerName: String {
        return "_gradientLayer"
    }
    
    fileprivate var gradientLayer: CAGradientLayer? {
        print((layer.sublayers ?? []).map { $0.name })
        
        for layer in layer.sublayers ?? [] {
            if layer.name == gradientLayerName,
                let gradientLayer = layer as? CAGradientLayer {
                
                return gradientLayer
            }
        }
        
        return nil
    }
    
}
