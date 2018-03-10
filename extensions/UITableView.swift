// MARK: - Convenient table view

extension UITableViewCell {

    static var identifier: String { return String(describing: self) }

}

extension UITableView {

    func dequeueReusableCell<CellClass: UITableViewCell>(of class: CellClass.Type,
                                                         for indexPath: IndexPath,
                                                         configure: ((CellClass) -> Void) = { _ in }) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CellClass.identifier, for: indexPath)

        if let typedCell = cell as? CellClass {
            configure(typedCell)
        }

        return cell
    }

    func registerCell<T>(_ cellClass: T) {
        register(UINib(nibName: String(describing: cellClass), bundle: nil), forCellReuseIdentifier: String(describing: cellClass))
    }

    func registerHeaderFooter<T>(_ headerFooterClass: T) {
        register(UINib(nibName: String(describing: headerFooterClass), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: headerFooterClass))
    }

}
