// MARK: - Storyboard helpers

extension UIViewController {

    class func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: String(describing: self))
    }

    class func instantiateFromStoryboard(storyboardName: String) -> Self {
        return instantiateFromStoryboardHelper(type: self, storyboardName: storyboardName)
    }

    private class func instantiateFromStoryboardHelper<T>(type: T.Type, storyboardName: String) -> T {
        let storyboad = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboad.instantiateViewController(withIdentifier: storyboardName) as! T

        return controller
    }
    
}
