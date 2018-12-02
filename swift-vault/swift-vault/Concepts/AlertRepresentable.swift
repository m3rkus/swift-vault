//
//  AlertRepresentable.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

protocol AlertRepresentable {
    
    func showSimpleAlert(title: String?,
                         message: String?,
                         okHandler: (() -> Void)?)
    
}

extension AlertRepresentable where Self: UIViewController {
    
    func showSimpleAlert(title: String?,
                         message: String?,
                         okHandler: (() -> Void)?) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
                                        okHandler?()
        }
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
    
}
