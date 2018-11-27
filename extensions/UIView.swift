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

    // Use it in layoutSubviews() to keep in sync view bound and shadow path
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

// MARK: - Gradient helper
public extension UIView {
    
    // MARK: - Public
    public typealias GradientVector = (startPoint: CGPoint, endPoint: CGPoint)
    
    public enum GradientDirection {
        
        case leftRight
        case rightLeft
        case topBottom
        case bottomTop
        case topLeftBottomRight
        case bottomRightTopLeft
        case topRightBottomLeft
        case bottomLeftTopRight
        
        var vector: GradientVector {
            switch self {
            case .leftRight:
                return (startPoint: CGPoint(x: 0, y: 0.5),
                        endPoint: CGPoint(x: 1, y: 0.5))
            case .rightLeft:
                return (startPoint: CGPoint(x: 1, y: 0.5),
                        endPoint: CGPoint(x: 0, y: 0.5))
            case .topBottom:
                return (startPoint: CGPoint(x: 0.5, y: 0),
                        endPoint: CGPoint(x: 0.5, y: 1))
            case .bottomTop:
                return (startPoint: CGPoint(x: 0.5, y: 1),
                        endPoint: CGPoint(x: 0.5, y: 0))
            case .topLeftBottomRight:
                return (startPoint: CGPoint(x: 0, y: 0),
                        endPoint: CGPoint(x: 1, y: 1))
            case .bottomRightTopLeft:
                return (startPoint: CGPoint(x: 1, y: 1),
                        endPoint: CGPoint(x: 0, y: 0))
            case .topRightBottomLeft:
                return (startPoint: CGPoint(x: 1, y: 0),
                        endPoint: CGPoint(x: 0, y: 1))
            case .bottomLeftTopRight:
                return (startPoint: CGPoint(x: 0, y: 1),
                        endPoint: CGPoint(x: 1, y: 0))
            }
        }
    }
    
    public func addGradientBackground(firstColor: UIColor,
                               secondColor: UIColor,
                               direction: GradientDirection) {
        var gLayer: CAGradientLayer
        
        if let layer = gradientLayer {
            gLayer = layer
        } else {
            gLayer = CAGradientLayer()
            gLayer.name = gradientLayerName
            self.layer.insertSublayer(gLayer, at: 0)
        }
        
        gLayer.frame = bounds
        gLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gLayer.startPoint = direction.vector.startPoint
        gLayer.endPoint = direction.vector.endPoint
    }
    
    public func removeGradientBackground() {
        gradientLayer?.removeFromSuperlayer()
    }
    
    // MARK: - Private
    fileprivate var gradientLayerName: String {
        return "_gradientLayer"
    }
    
    fileprivate var gradientLayer: CAGradientLayer? {
        print((layer.sublayers ?? []).map { $0.name })
        
        for layer in layer.sublayers ?? [] {
            if layer.name == gradientLayerName,
                let gradientLayer = layer as? CAGradientLayer {
                
                return gradientLayer
            }
        }
        
        return nil
    }
    
}

// MARK: - Animation helpers

extension UIView {

    func animateConstraints(duration: TimeInterval,
                            options: UIViewAnimationOptions = [],
                            completion: (() -> Void)? = nil,
                            forcePendingLayout: Bool = true) {

        if forcePendingLayout {
            self.layoutIfNeeded()
        }
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }

    // Disturbs the view. Useful for getting the user's attention when something changed.
    func disturb() {
        transform = CGAffineTransform(scaleX: 0.98, y: 0.98)

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 150, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            self.transform = .identity
        }, completion: nil)
    }

    // Shakes the view. Useful for displaying failures to users.
    func shake() {
        transform = CGAffineTransform(translationX: 10, y: 0)

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: [.curveEaseOut, .beginFromCurrentState, .allowUserInteraction], animations: {
            self.transform = .identity
        }, completion: nil)
    }

    // Add content changing animation with fade transition
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
        kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }

}
