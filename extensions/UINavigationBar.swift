
// MARK: - Gradient for navigation bar
struct GradientComponents {
    var colors: [CGColor]
    var locations: [NSNumber]
    var startPoint: CGPoint
    var endPoint: CGPoint
}

extension UINavigationBar {

    func applyNavigationBarGradient(with components: GradientComponents) {

        let size = CGSize(width: UIScreen.main.bounds.size.width, height: 1)
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        gradient.colors = components.colors
        gradient.locations = components.locations
        gradient.startPoint = components.startPoint
        gradient.endPoint = components.endPoint

        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.barTintColor = UIColor(patternImage: image!)
    }
}
