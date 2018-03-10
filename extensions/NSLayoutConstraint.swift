// MARK: - Constraint helpers

extension NSLayoutConstraint {

    func activate() {
        NSLayoutConstraint.activate([self])
    }

    func deactivate() {
        NSLayoutConstraint.deactivate([self])
    }

    @discardableResult func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

    NSLayoutConstraint.deactivate([self])

    let newConstraint = NSLayoutConstraint(
        item: firstItem,
        attribute: firstAttribute,
        relatedBy: relation,
        toItem: secondItem,
        attribute: secondAttribute,
        multiplier: multiplier,
        constant: constant)

    newConstraint.priority = priority
    newConstraint.shouldBeArchived = self.shouldBeArchived
    newConstraint.identifier = self.identifier

    NSLayoutConstraint.activate([newConstraint])
    return newConstraint
}

}
