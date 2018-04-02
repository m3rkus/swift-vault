// Used with text fields & search bars for detecting
// a moment when user stop typing text

class ViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
    }

    @objc
    func textFieldDidEndTyping(_ textField: UITextField) {
        print("Finished typing text in textField")
    }

}

extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(textFieldDidEndTyping(_:)), object: textField)
        self.perform(#selector(textFieldDidEndTyping(_:)), with: textField, afterDelay: 0.5)
        return true
    }

}
