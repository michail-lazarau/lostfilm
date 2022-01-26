import UIKit

class NavigationViewButton: UIButton {
    convenience init() {
        self.init(frame: .zero)
        setupAppearance()
    }

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }

//    override var isHighlighted: Bool {
//        didSet {
//            UIView.animate(withDuration: 0.15) { [self] in
//                imageView?.tintColor = isHighlighted ? .lightGray : .white
//            }
//        }
//    }

    private func setupAppearance() {
        setTitle("Show series", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        backgroundColor = .lightGray
        layer.cornerRadius = 8.0
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
         // Drawing code
     }
     */
}
