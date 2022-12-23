import UIKit

class AlertWindow: UIWindow {
//    let label: UIButton

//    init(label: UIButton, windowScene: UIWindowScene) {
//        self.label = label
//        super.init(windowScene: windowScene)
//    backgroundColor = .clear
//    windowLevel = UIWindow.Level.alert
//        let presentingController = UIViewController()
//        presentingController.view.backgroundColor = .clear
//        presentingController.view.isUserInteractionEnabled = false
//        presentingController.view.addSubview(label)
//        rootViewController = presentingController
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.isUserInteractionEnabled = true
//        label.addTarget(self, action: #selector(tap), for: .touchUpInside)
//        let centerX = label.centerXAnchor.constraint(equalTo: presentingController.view.centerXAnchor)
//        let centerY = label.centerYAnchor.constraint(equalTo: presentingController.view.centerYAnchor)
//        NSLayoutConstraint.activate([
//            centerX, centerY,
//        ])
//    }

    //    @objc func tap() {
    //        print("Tap alertWindow button")
    //    }

//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if label.frame.contains(point) {
//            return label
//        }
//        return nil
//    }

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
