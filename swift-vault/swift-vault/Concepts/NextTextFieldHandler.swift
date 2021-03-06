//
//  NextTextFieldHandler.swift
//  swift-vault
//
//  Created by m3rk on 02/12/2018.
//  Copyright © 2018 m3rk edge. All rights reserved.
//

import UIKit

protocol NextTextFieldHandler {
    
    var textFields: [UITextField] { get }
    
    func setupReturnKeyType(for textField: UITextField,
                            finalAction: Selector?,
                            sender: Any?)
    func handleReturnKeyTapped(on textField: UITextField)
    
}

// MARK: - Public Methods
extension NextTextFieldHandler {
    
    func setupReturnKeyType(for textField: UITextField,
                            finalAction: Selector?,
                            sender: Any?) {
        let textFields = _textFields
        
        guard let currentIndex = textFields.index(of: textField) else {
            return
        }
        
        let emptyFieldsExistAfterCurrent = emptyFieldsExist(after: textField)
        
        if currentIndex < textFields.endIndex - 1,
            emptyFieldsExistAfterCurrent {
            
            textField.returnKeyType = .next
        } else {
            textField.returnKeyType = .done
            if let finalAction = finalAction, let sender = sender {
                textField.addTarget(sender,
                                    action: finalAction,
                                    for: .editingDidEndOnExit)
            }
        }
    }
    
    func handleReturnKeyTapped(on textField: UITextField) {
        let textFields = _textFields
        
        guard let currentIndex = textFields.index(of: textField) else {
            return
        }
        
        let fieldsAfterCurrent = fields(after: textField)
        let nextEmptyIndex = fieldsAfterCurrent
            .firstIndex { $0.text?.isEmpty != false }
            ?? textFields.index(currentIndex,
                                offsetBy: 1,
                                limitedBy: textFields.endIndex - 1)
            ?? textFields.endIndex - 1
        let emptyFieldsExistAfterCurrent = emptyFieldsExist(after: textField)
        
        if currentIndex == textFields.endIndex - 1 ||
            !emptyFieldsExistAfterCurrent {
            
            textField.resignFirstResponder()
        } else {
            textFields[nextEmptyIndex].becomeFirstResponder()
        }
    }
    
}

// MARK: - Private Methods
private extension NextTextFieldHandler {
    
    var _textFields: [UITextField] {
        return textFields.filter { !$0.isHidden &&
            $0.alpha != 0 &&
            $0.isEnabled }
    }
    
    func fields(after textField: UITextField) -> ArraySlice<UITextField> {
        let textFields = _textFields
        
        guard let currentIndex = textFields.index(of: textField) else {
            return []
        }
        
        return textFields.suffix(from: min(currentIndex + 1,
                                           textFields.endIndex - 1))
    }
    
    func emptyFieldsExist(after textField: UITextField) -> Bool {
        return fields(after: textField)
            .filter { $0.text?.isEmpty != false }
            .isEmpty == false
    }
    
}


// *****************************
// ********** USAGE ************
// *****************************

final class TextFieldHandlerViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    
    lazy var handledTextFields: [UITextField] = {
        return [
            firstTextField,
            secondTextField,
            thirdTextField,
            fourthTextField
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handledTextFields.forEach { $0.delegate = self }
    }
    
}

extension TextFieldHandlerViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setupReturnKeyType(for: textField,
                           finalAction: nil,
                           sender: nil)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleReturnKeyTapped(on: textField)
        return true
    }
    
}

extension TextFieldHandlerViewController: NextTextFieldHandler {
    
    var textFields: [UITextField] {
        return handledTextFields
    }
    
}
