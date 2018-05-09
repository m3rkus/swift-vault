// MARK: - View that let underneath views respond to touch events

class PassthroughView: UIView {

    var isPassthroughEvents: Bool = false

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isPassthroughEvents {
            let view = super.hitTest(point, with: event)
            return view == self ? nil : view
        } else {
            return super.hitTest(point, with: event)
        }
    }

}
