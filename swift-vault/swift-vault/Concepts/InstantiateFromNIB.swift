
//
//  InstantiateFromNIB.swift
//  swift-vault
//
//  Created by m3rk on 08/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func instantiateFromNib<T : UIView>() -> T? {
        
        guard let view = Bundle.main.loadNibNamed(
            String(describing: type(of: self)),
            owner: self,
            options: nil)?[0] as? T
        else {
            return nil
        }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        return view
    }
    
}
