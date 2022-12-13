import UIKit

final class ProfileButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(title: nil, titleColor: nil, backgroundColor: nil)
    }

    init(title: String?, titleColor: UIColor?, backgroundColor: UIColor?) {
        super.init(frame: .zero)
        setup(title: title, titleColor: titleColor, backgroundColor: backgroundColor)
    }

    private func setup(title: String?, titleColor: UIColor?, backgroundColor: UIColor?) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

    override var isHighlighted: Bool {
        willSet {
            UIView.animate(withDuration: 0.15) {
                self.alpha = !self.isHighlighted ? 0.5 : 1.0
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}
