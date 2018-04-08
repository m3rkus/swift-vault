// Handling keyboard showing & hiding for screen view animation

class ViewController: UIViewController {

    var keyboardHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }

        if view.frame.origin.y == 0 {
            let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]

            UIView.animate(withDuration: animationDuration as! TimeInterval) {
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: (self.view.window?.frame.height)! - self.keyboardHeight)
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.2) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIScreen.main.bounds.height)
            self.view.layoutIfNeeded()
        }
    }

}
