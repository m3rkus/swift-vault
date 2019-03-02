//
//  KeyboardHandler.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

/// Shift passed view according to keyboard opening/closing

/// Usage: instantiate KeyboardAvoider and pass view to shift when keyboard opening/closing
/// keep KeyboardAvoider reference in memory while need to manage keyboard avoidance

final class KeyboardAvoider {
    
    // MARK: - Private Properties
    private weak var view: UIView?
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle
    init(view: UIView) {
        
        self.view = view
        setup()
    }
}

// MARK: - Private Methods
private extension KeyboardAvoider {
    
    func setup() {
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(closeKeyboard))
        tap.cancelsTouchesInView = false
        view?.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        
        if view?.frame.origin.y == 0 {
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
            
            UIView.animate(withDuration: animationDuration as! TimeInterval) {
                self.view?.frame = CGRect(x: 0,
                                          y: 0,
                                          width: self.view?.frame.width ?? UIScreen.main.bounds.width,
                                          height: (self.view?.window?.frame.height)! - self.keyboardHeight)
                self.view?.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.2) {
            self.view?.frame = CGRect(x: 0,
                                      y: 0,
                                      width: self.view?.frame.width ?? UIScreen.main.bounds.width,
                                      height: UIScreen.main.bounds.height)
            self.view?.layoutIfNeeded()
        }
    }
    
    @objc func closeKeyboard() {
        view?.endEditing(true)
    }
}
