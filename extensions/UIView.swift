// 📍 Dependencies:
// - NSLayoutConstraint extensions

// MARK: - NIB helpers
extension UIView {

    @discardableResult
    func instantiateFromNib<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {
            return nil
        }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fill(view: self)
        return view
    }

}

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

// MARK: - Animation helpers
extension UIView {

    // Disturbs the view. Useful for getting the user's attention when something changed.
    public func disturb() {
        transform = CGAffineTransform(scaleX: 0.98, y: 0.98)

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 150, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            self.transform = .identity
        }, completion: nil)
    }

    // Shakes the view. Useful for displaying failures to users.
    public func shake() {
        transform = CGAffineTransform(translationX: 10, y: 0)

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            self.transform = .identity
        }, completion: nil)
    }

}
