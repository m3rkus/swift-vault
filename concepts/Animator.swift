/// Animations Helper with beauty of Swift power

// Usage:
// awesomeView.animate ([
//     .scale(to: awesomeView.frame.size * 1.5, duration: 0.3),
//     .move(to: anotherView.center, duration: 0.3)
// ])

struct Animation {
    var duration: TimeInterval
    var closure: (UIView) -> Void
}

extension Animation {

    static func fadeIn(duration: TimeInterval) -> Animation {
        return Animation(duration: duration) { $0.alpha = 1 }
    }

    static func scale(toSize newSize: CGSize, duration: TimeInterval) -> Animation {
        return Animation(duration: duration) { $0.frame.size = newSize }
    }

}

extension UIView {

    func animate(_ animations: [Animation]) {
        guard animations.isEmpty == false else {
            return
        }

        var animations = animations
        let animation = animations.removeFirst()

        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }, completion: { _ in
            self.animate(animations)
        })
    }

}
