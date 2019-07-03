//
//  PowerLayout.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

extension UIView {
    
    func add(subviews: UIView ...) {
        
        subviews.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension UILayoutPriority {
    
    static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue + rhs)
    }
    
    static func -(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(lhs.rawValue - rhs)
    }
    
}

extension NSLayoutConstraint {
    
    func set(priority: UILayoutPriority, isActive: Bool) {
        
        self.priority = priority
        self.isActive = isActive
    }
    
}


@objc extension NSLayoutAnchor {
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to anchor: NSLayoutAnchor,
                   with constant: CGFloat = 0.0,
                   prioritizeAs priority: UILayoutPriority = .required,
                   isActive: Bool = true) -> NSLayoutConstraint {
        
        var constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalTo: anchor, constant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualTo: anchor, constant: constant)
        }
        
        constraint.set(priority: priority, isActive: isActive)
        
        return constraint
    }
}

extension NSLayoutDimension {
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to anchor: NSLayoutDimension,
                   with constant: CGFloat = 0.0,
                   multiplyBy multiplier: CGFloat = 1.0,
                   prioritizeAs priority: UILayoutPriority = .required,
                   isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        }
        
        constraint.set(priority: priority, isActive: isActive)
        
        return constraint
    }
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to constant: CGFloat = 0.0,
                   prioritizeAs priority: UILayoutPriority = .required,
                   isActive: Bool = true) -> NSLayoutConstraint {
        
        var constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalToConstant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualToConstant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualToConstant: constant)
        }
        
        constraint.set(priority: priority, isActive: isActive)
        
        return constraint
    }
}

extension UIView {
    
    func constrainEdges(to view: UIView) {
        self.leadingAnchor.constrain(to: view.leadingAnchor)
        self.topAnchor.constrain(to: view.topAnchor)
        self.trailingAnchor.constrain(to: view.trailingAnchor)
        self.bottomAnchor.constrain(to: view.bottomAnchor)
    }
}

final class SampleView: UIView {
    
    func layout() {
        // Subviews
        let logoImageView = UIImageView()
        let welcomeLabel = UILabel()
        let dismissButton = UIButton()
        
        // Add Subviews & Set view's translatesAutoresizingMaskIntoConstraints to false
        add(subviews: logoImageView, welcomeLabel, dismissButton)
        
        // Set Constraints
        logoImageView.topAnchor.constrain(to: topAnchor, with: 12)
        logoImageView.centerXAnchor.constrain(to: centerXAnchor)
        logoImageView.widthAnchor.constrain(to: 50)
        logoImageView.heightAnchor.constrain(to: 50)
        
        dismissButton.leadingAnchor.constrain(.greaterThanOrEqual, to: leadingAnchor, with: 12)
        dismissButton.trailingAnchor.constrain(.lessThanOrEqual, to: trailingAnchor, with: -12)
        dismissButton.bottomAnchor.constrain(to: bottomAnchor)
        dismissButton.widthAnchor.constrain(to: 320, prioritizeAs: .defaultHigh + 1)
        
        welcomeLabel.topAnchor.constrain(to: logoImageView.bottomAnchor, with: 12)
        welcomeLabel.bottomAnchor.constrain(.greaterThanOrEqual, to: dismissButton.topAnchor, with: 12)
        welcomeLabel.leadingAnchor.constrain(to: dismissButton.leadingAnchor)
        welcomeLabel.trailingAnchor.constrain(to: dismissButton.trailingAnchor)
    }
    
}
