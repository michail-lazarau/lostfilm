import UIKit

class OrderNumberLabel: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let customContentSize = text?.count == 3
        ? originalContentSize
        : (text?.count == 2 ? CGSize(width: originalContentSize.width * 1.5, height: originalContentSize.height)
           : CGSize(width: originalContentSize.width * 3, height: originalContentSize.height))
        return customContentSize
    }
}
