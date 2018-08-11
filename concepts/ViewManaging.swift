public protocol ViewManaging {
    associatedtype ContentView: UIView
}

extension ViewManaging where Self: UIViewController {
    /// The UIViewController's custom view.
    public var contentView: ContentView {
        guard let contentView = view as? ContentView else {
            fatalError("Expected view to be of type \(ContentView.self) but got \(type(of: view)) instead")
        }
        return contentView
    }
}

// Usage
final class ViewController: UIViewController, ViewManaging {

    typealias ContentView = MyView

    override func loadView() {
        let customView = CustomView()
        customView.delegate = self
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.render() //some MyView specific method
    }

}
