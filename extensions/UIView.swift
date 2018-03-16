// 📍 Dependencies:
// - NSLayoutConstraint extensions

// MARK: - View helpers

extension UIView {

    func makeRound() {
        self.layer.cornerRadius = frame.size.width / 2
    }

    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func addShadow(color: UIColor, offset: CGSize, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.clipsToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
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
        widthAnchor.constraint(equalTo: view.widthAnchor).activate()
        heightAnchor.constraint(equalTo: view.heightAnchor).activate()
    }

    // Usage:
    // redView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,
    //                padding: .init(top: 0, left: 0, bottom: 0, right: 12),
    //                size: .init(width: 125, height: 0))
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).activate()
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).activate()
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).activate()
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).activate()
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).activate()
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).activate()
        }
    }

}
