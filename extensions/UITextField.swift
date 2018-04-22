// MARK: - Textfield chain with next/done buttons and final action

extension UITextField {

    class func connectFields(fields: UITextField ...,
                             finalAction: Selector? = nil,
                             sender: Any? = nil) {
        guard let lastField = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        lastField.returnKeyType = .done
        lastField.addTarget(lastField, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
        if let finalAction = finalAction, let sender = sender {
            lastField.addTarget(sender, action: finalAction, for: .editingDidEndOnExit)
        }
    }

}
