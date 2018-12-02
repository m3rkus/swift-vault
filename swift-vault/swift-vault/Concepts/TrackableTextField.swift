//
//  TrackableTextField.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

/// Used with text fields & search bars for detecting
/// a moment when user stop typing text

class SampleViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
    }
    
    @objc func textFieldDidEndTyping(_ textField: UITextField) {
        print("Finished typing text in textField")
    }
    
}

extension SampleViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(textFieldDidEndTyping(_:)),
                                               object: textField)
        self.perform(#selector(textFieldDidEndTyping(_:)),
                     with: textField,
                     afterDelay: 1.5)
        return true
    }
    
}
