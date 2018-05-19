// MARK: - Self sized table view

// Set maxHeight to specific height, default is screen height
// Don't set auto layout height for tableView, instead set
// instrinsic content size property to 'placeholder' or (0, 0)

class SelfSizedTableView: UITableView {

    var maxHeight: CGFloat = UIScreen.main.bounds.size.height

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }

    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }

}
