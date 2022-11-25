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
        let maxNumOfDigits = 3

        guard let actualNumOfDigits = text?.count else {
            return originalContentSize
        }

        let widthMultiplier = CGFloat(maxNumOfDigits) / CGFloat(actualNumOfDigits)
        return CGSize(width: originalContentSize.width * widthMultiplier, height: originalContentSize.height)
    }
}
