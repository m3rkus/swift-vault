// MARK: - Convenient collection view

extension UICollectionViewCell {

    static var identifier: String { return String(describing: self) }

}

extension UICollectionView {

    func dequeueReusableCell<CellClass: UICollectionViewCell>(of class: CellClass.Type,
                                                         for indexPath: IndexPath,
                                                         configure: ((CellClass) -> Void) = { _ in }) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CellClass.identifier, for: indexPath)
        if let typedCell = cell as? CellClass {
            configure(typedCell)
        }

        return cell
    }

    func registerCell<T>(_ cellClass: T) {
        register(UINib(nibName: String(describing: cellClass), bundle: nil), forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func registerSectionHeader<T>(_ cellClass: T) {
        register(UINib(nibName: String(describing: cellClass), bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: cellClass))
    }

}
