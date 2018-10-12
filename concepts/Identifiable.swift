import UIKit


public protocol Identifiable {

    static var identifier: String { get }

}

public extension Identifiable {

    public static var identifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: Identifiable {}

extension UITableViewHeaderFooterView: Identifiable {}

extension UICollectionReusableView: Identifiable {}
