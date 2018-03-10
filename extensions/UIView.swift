// MARK: - View helpers

extension UIView {

    func makeRound() {
        self.layer.cornerRadius = frame.size.width / 2
    }

    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

}

// MARK: - Autolayout helpers

extension UIView {

    func fill(view: UIView?) {
        anchor(top: view?.topAnchor, leading: view?.leadingAnchor,
               bottom: view?.bottomAnchor, trailing: view?.trailingAnchor)
    }

    func fillSuperview() {
        fill(view: superview)
    }

    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    // Usage:
    // redView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,
    //                padding: .init(top: 0, left: 0, bottom: 0, right: 12),
    //                size: .init(width: 125, height: 0))
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

}
