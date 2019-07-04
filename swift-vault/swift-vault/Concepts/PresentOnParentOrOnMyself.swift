//
//  PresentOnParentOrOnMyself.swift
//  swift-vault
//
//  Created by m3rkus on 04/07/2019.
//  Copyright © 2019 m3rk edge. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentOnParentOrOnMyself(vc: UIViewController,
                                   modal: Bool) {
        
        if modal {
            if let parentVC = parent {
                parentVC.present(vc, animated: true)
            } else {
                present(vc, animated: true)
            }
        } else {
            if let parentNavController = parent?.navigationController {
                parentNavController.pushViewController(vc, animated: true)
            } else {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
