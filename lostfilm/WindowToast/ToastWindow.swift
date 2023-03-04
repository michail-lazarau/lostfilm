import UIKit

class ToastWindow: UIWindow {
    init(rootViewController: UIViewController, windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        self.rootViewController = rootViewController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return rootViewController?.view.subviews.first { $0.frame.contains(point) }
    }
}
