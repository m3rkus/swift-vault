// 📍 Dependencies:
// - UIView extensions

// MARK: - Autolayout helpers

extension UIStackView {

    func fillBackground(color: UIColor, cornerRadius: CGFloat) {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadius

        view.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(view, at: 0)
        view.fill(view: self)
    }

}
