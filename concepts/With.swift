// With comcept


public func with<T>(_ item: inout T, action: (inout T) -> Void) {
    action(&item)
}

public func with<T>(_ item: T, action: (T) -> Void) {
    action(item)
}

public func with<T: AnyObject>(_ item: T, action: (T) -> Void) {
    action(item)
}

/**
 * Instead of:
 *
 * attributes.frame.size = CGSize(width: size.width + 10, height: 23)
 * attributes.frame.left = attributes.iconViewFrame.right + 8
 * attributes.frame.top = 8
 *
 * use:
 *
 * with(&attributes.frame) {
 *     $0.size = CGSize(width: size.width + 10, height: 23)
 *     $0.left = attributes.iconViewFrame.right + 8
 *     $0.top = 8
 * }
 *
 */
