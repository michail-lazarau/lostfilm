import UIKit

// https://medium.com/swlh/create-loading-buttons-in-ios-using-swift-63ec77eebda
class LoadingButton: UIButton {
    var isLoading: Bool = false
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func layoutSubviews() {
            super.layoutSubviews()
            indicator.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        }

    /**
     Display the loader inside the button.
     - Parameter userInteraction: Enable the user interaction while displaying the loader.
     */
    open func showLoader(userInteraction: Bool) {
        guard !self.subviews.contains(indicator) else { return }
        // Set up loading indicator
        isLoading = true
        addSubview(indicator)
        isUserInteractionEnabled = userInteraction
        UIView.transition(with: self, duration: 0.2, options: .curveEaseOut, animations: { [weak titleLabel, imageView] in
            [titleLabel, imageView].forEach { $0?.alpha = 0.0 }
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            if self.isLoading {
                self.indicator.startAnimating()
            } else {
                self.hideLoader()
            }
        })
    }
    /**
     Hide the loader displayed.
     */
    open func hideLoader() {
        guard self.subviews.contains(indicator) else { return }
        isLoading = false
        self.isUserInteractionEnabled = true
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        UIView.transition(with: self, duration: 0.2, options: .curveEaseIn, animations: { [weak titleLabel, imageView] in
            [titleLabel, imageView].forEach { $0?.alpha = 1.0 }
        })
    }
}
