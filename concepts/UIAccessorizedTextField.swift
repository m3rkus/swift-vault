//  AccessorizedTextField
// iOS friendly alternative to the drop down list

// Usage:
// @IBOutlet weak var emailTextField: UIAccessorizedTextField!
//
// override func viewDidLoad() {
//     super.viewDidLoad()
//     self.emailTextField.accessoryStrings = [ "One", "Two", "Three" ]
//     self.emailTextField.shouldHighlightFilter = true
// }


import Foundation
import UIKit

/*
 This enumeration describes the internal layout of the cell's frame to
 the cell instance.

 Magic numbers are encapsulated here

 If there is something different in the behaviour between types of cell
 it should be encapsulated here.
 */

@objc enum UIAccessorizedTextFieldCellStyle : Int {
    case normalOneLine
    case wideTwoLine

    internal func cellType() -> UIAccessorizedTextFieldCollectionViewCell.Type {
        switch self {
        case .normalOneLine: return UIAccessorizedTextFieldCollectionViewCellNormalOneLine.self
        case .wideTwoLine: return UIAccessorizedTextFieldCollectionViewCellWideTwoLine.self
        }
    }

    internal func cellSize() -> CGSize {
        switch self {
        case .normalOneLine:
            let width = self.accessoryViewSize().width * 0.35
            let height = self.accessoryViewSize().height
            return CGSize(width: width, height: height)
        case .wideTwoLine:
            let width = self.accessoryViewSize().width * 0.7
            let height = self.accessoryViewSize().height
            return CGSize(width: width, height: height)
        }
    }

    internal func cellHorizontalInset() -> CGFloat {
        switch self {
        case .normalOneLine:
            return 5.0
        case .wideTwoLine:
            return 5.0
        }
    }

    internal func cellVerticalInset() -> CGFloat {
        switch self {
        case .normalOneLine:
            return 0.2 * self.cellSize().height
        case .wideTwoLine:
            return 0.125 * self.cellSize().height
        }
    }

    internal func accessoryViewSize() -> CGSize {

        let viewHeight = UIScreen.main.bounds.size.height * 0.1
        let viewWidth = UIScreen.main.bounds.size.width

        return CGSize(width: viewWidth, height: viewHeight)
    }

    internal func numberOfLinesOfText() -> Int {
        switch self {
        case .normalOneLine:
            return 1
        case .wideTwoLine:
            return 2
        }
    }

    internal func normalFont() -> UIFont {
        return UIFont.systemFont(ofSize: 14.0)
    }

    internal func boldFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 14.0)
    }

    internal func foregroundColor() -> UIColor {
        return UIColor.black
    }

    internal func backgroundColor() -> UIColor {
        return UIColor.white
    }

    internal func selectedBackgroundColor() -> UIColor {
        return UIColor.lightGray
    }
}

/*

 Exposes public variables for controlling behaviour.

 usage:

 myAutoCompletetextField.accessoryStrings = ["MK10 0AB", "W1T 3NQ"]
 the text field will add a non standard input accessory view with only those strings

 myAutoCompletetextField.shouldHighlightFilter = true; default is false
 strings which are filtering true have the highlight in bold

 myAutoCompletetextField.testPrefixOnly = true; default is false
 filtering is done on the prefix of the string

 myAutoCompletetextField.cellStyle = .wideTwoLine; default is .normalOneLine
 two styles of cell for you to get started with

 */

@IBDesignable class UIAccessorizedTextField : UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.didLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.didLoad()
    }

    func didLoad() {
        self.inputAccessoryView = .none
        self.autocorrectionType = .no

        self.addTarget(self, action: #selector(UIAccessorizedTextField.didChange as (UIAccessorizedTextField) -> () -> ()), for: .editingChanged)
    }

    @objc internal func didChange() {
        self.stringsCollectionView.reloadData()
    }

    @objc public var accessoryStrings : [String]? = .none {
        didSet {
            if accessoryStrings?.count != 0 {
                self.inputAccessoryView = self.accessoryView
                self.autocorrectionType = .no
            }
        }
    }

    @objc public var cellStyle : UIAccessorizedTextFieldCellStyle = .normalOneLine

    @objc public var shouldHighlightFilter : Bool = false

    @objc public var testPrefixOnly : Bool = false

    lazy internal var accessoryView : UIAccessorizedTextFieldAccessoryView? = {

        var frame : CGRect = .zero
        frame.size = self.cellStyle.accessoryViewSize()

        let temp = UIAccessorizedTextFieldAccessoryView(frame: frame)

        temp.backgroundColor = UIColor.clear
        temp.translatesAutoresizingMaskIntoConstraints = false
        // This is required to make the view grow vertically
        temp.autoresizingMask = UIViewAutoresizing.flexibleHeight
        temp.addSubview(self.blurEffectView)
        temp.addSubview(self.stringsCollectionView)

        return temp
    }()

    lazy internal var stringsCollectionView : UICollectionView = {

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 10.0)

        var frame : CGRect = .zero
        frame.size = self.cellStyle.accessoryViewSize()

        let temp = UICollectionView(frame: frame, collectionViewLayout: flowLayout)

        temp.register(UIAccessorizedTextFieldCollectionViewCellNormalOneLine.self, forCellWithReuseIdentifier: UIAccessorizedTextFieldCollectionViewCellNormalOneLine.identifier())

        temp.register(UIAccessorizedTextFieldCollectionViewCellWideTwoLine.self, forCellWithReuseIdentifier: UIAccessorizedTextFieldCollectionViewCellWideTwoLine.identifier())

        temp.backgroundColor = .clear // UIColor.black.withAlphaComponent(0.6)
        temp.delegate = self
        temp.dataSource = self

        return temp
    }()

    lazy internal var blurEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let temp = UIVisualEffectView(effect: blurEffect)

        var frame : CGRect = .zero
        frame.size = self.cellStyle.accessoryViewSize()

        temp.frame = frame
        temp.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return temp
    }()
}

class UIAccessorizedTextFieldAccessoryView : UIView {
    internal var viewSize : CGSize = .zero

    override init(frame: CGRect) {
        self.viewSize = frame.size
        super.init(frame: frame)

        // This is required to make the view grow vertically
        self.autoresizingMask = UIViewAutoresizing.flexibleHeight
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return self.viewSize
    }
}

extension UIAccessorizedTextField {
    func isFiltered() -> Bool {
        let isFiltered = self.filter() != "" ? true : false

        return isFiltered
    }

    func filter() -> String {
        let filter = self.text ?? ""

        return filter
    }

    func unfilteredAccessoryStrings() -> [String] {
        let unfilteredAccessoryStrings = self.accessoryStrings ?? [String]()

        return unfilteredAccessoryStrings
    }

    func testPrefix(string : String) -> Bool {
        return string.lowercased().hasPrefix(self.filter().lowercased())
    }

    func testInfix(string : String) -> Bool {
        return string.lowercased().range(of: self.filter().lowercased()) != .none
    }

    func filteredAccessoryStrings() -> [String] {

        let filteredAccessoryStrings = self.unfilteredAccessoryStrings().filter { string in
            if self.testPrefixOnly {
                return self.testPrefix(string: string)
            } else {
                return self.testInfix(string: string)
            }
        }

        return filteredAccessoryStrings
    }

    func accessoryString(_ indexpath : IndexPath) -> String {
        let accessoryString = self.isFiltered() ? self.filteredAccessoryStrings()[indexpath.row] : self.unfilteredAccessoryStrings()[indexpath.row]

        return accessoryString
    }

    func accessoryAttributedString(_ indexpath : IndexPath, cellStyle: UIAccessorizedTextFieldCellStyle) -> NSAttributedString {
        let accessoryString = self.accessoryString(indexpath)

        let normalAttributes : [NSAttributedStringKey: Any] = [.font: cellStyle.normalFont()]

        let accessoryAttributedString = NSMutableAttributedString(string: accessoryString, attributes: normalAttributes)

        if !self.shouldHighlightFilter || !self.isFiltered() {
            return accessoryAttributedString
        }

        if let range = accessoryString.lowercased().range(of: self.filter().lowercased()) {

            let nsrange = NSRange(range, in: accessoryString)

            let boldAttributes : [NSAttributedStringKey: Any] = [.font: cellStyle.boldFont()]

            let highlightedAccessoryAttributedString = accessoryAttributedString

            highlightedAccessoryAttributedString.addAttributes(boldAttributes, range: nsrange)

            return highlightedAccessoryAttributedString

        } else {
            return accessoryAttributedString
        }
    }
}

extension UIAccessorizedTextField : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItemsInSection = self.isFiltered() ? self.filteredAccessoryStrings().count : self.unfilteredAccessoryStrings().count

        return numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellStyle.cellType().identifier(), for: indexPath) as! UIAccessorizedTextFieldCollectionViewCell

        cell.textLabel?.attributedText = self.accessoryAttributedString(indexPath, cellStyle: self.cellStyle)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.text = self.accessoryString(indexPath)

        self.didChange()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellStyle.cellSize()
    }
}

internal class UIAccessorizedTextFieldCollectionViewCell : UICollectionViewCell {
    public class func identifier() -> String {
        return "UIAccessorizedTextFieldCollectionViewCell"
    }

    var textLabel: UILabel? = .none
    internal var lozengeView: UIView? = .none

    internal var lozengeViewColor: UIColor {
        return .red
    }

    internal var textColor: UIColor {
        return .green
    }

    internal var selectedLozengeColor: UIColor {
        return .lightGray
    }

    internal var hPadding: CGFloat {
        return 5.0
    }

    internal var vPadding: CGFloat {
        return 5.0
    }

    internal var normalFont: UIFont {
        return UIFont.systemFont(ofSize: 14.0)
    }

    internal var numberOfLinesOfText: Int {
        return 1
    }

    override var isHighlighted: Bool {
        didSet {
            let color: UIColor = isHighlighted ? self.selectedLozengeColor : self.lozengeViewColor
            self.lozengeView?.backgroundColor = color
            self.lozengeView?.layer.borderColor = color.cgColor
        }
    }

    override var isSelected: Bool {
        didSet {
            let color: UIColor = isSelected ? self.selectedLozengeColor : self.lozengeViewColor
            self.lozengeView?.backgroundColor = color
            self.lozengeView?.layer.borderColor = color.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let lozengeViewFrame = CGRect(x: self.hPadding, y: self.vPadding, width: frame.size.width, height: frame.size.height - (2.0 * self.vPadding))
        self.lozengeView = UIView(frame: lozengeViewFrame)

        guard let lozengeView = self.lozengeView else { return }

        let color: UIColor = isSelected ? self.selectedLozengeColor : self.lozengeViewColor

        lozengeView.backgroundColor = color
        lozengeView.layer.cornerRadius = 5.0
        lozengeView.layer.borderWidth = 2.0
        lozengeView.layer.borderColor = color.cgColor

        let textLabelFrame = CGRect(x: 2.0, y: 2.0, width: lozengeViewFrame.size.width - 4.0, height: lozengeViewFrame.size.height - 4.0)
        self.textLabel = UILabel(frame: textLabelFrame)

        guard let textLabel = self.textLabel else { return }

        textLabel.font = self.normalFont
        textLabel.textColor = self.textColor
        textLabel.textAlignment = .center
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.backgroundColor = .clear
        textLabel.numberOfLines = self.numberOfLinesOfText

        contentView.addSubview(lozengeView)
        lozengeView.addSubview(textLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal class UIAccessorizedTextFieldCollectionViewCellNormalOneLine : UIAccessorizedTextFieldCollectionViewCell {
    public override class func identifier() -> String {
        return "UIAccessorizedTextFieldCollectionViewCellNormalOneLine"
    }

    override var hPadding: CGFloat {
        return UIAccessorizedTextFieldCellStyle.normalOneLine.cellHorizontalInset()
    }

    override var vPadding: CGFloat {
        return UIAccessorizedTextFieldCellStyle.normalOneLine.cellVerticalInset()
    }

    override var lozengeViewColor: UIColor {
        return UIAccessorizedTextFieldCellStyle.normalOneLine.backgroundColor()
    }

    override var textColor: UIColor {
        return UIAccessorizedTextFieldCellStyle.normalOneLine.foregroundColor()
    }

    override var numberOfLinesOfText: Int {
        return UIAccessorizedTextFieldCellStyle.normalOneLine.numberOfLinesOfText()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal class UIAccessorizedTextFieldCollectionViewCellWideTwoLine : UIAccessorizedTextFieldCollectionViewCell {
    public override class func identifier() -> String {
        return "UIAccessorizedTextFieldCollectionViewCellWideTwoLine"
    }

    override var hPadding: CGFloat {
        return UIAccessorizedTextFieldCellStyle.wideTwoLine.cellHorizontalInset()
    }

    override var vPadding: CGFloat {
        return UIAccessorizedTextFieldCellStyle.wideTwoLine.cellVerticalInset()
    }

    override var lozengeViewColor: UIColor {
        return UIAccessorizedTextFieldCellStyle.wideTwoLine.backgroundColor()
    }

    override var textColor: UIColor {
        return UIAccessorizedTextFieldCellStyle.wideTwoLine.foregroundColor()
    }

    override var numberOfLinesOfText: Int {
        return UIAccessorizedTextFieldCellStyle.wideTwoLine.numberOfLinesOfText()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
