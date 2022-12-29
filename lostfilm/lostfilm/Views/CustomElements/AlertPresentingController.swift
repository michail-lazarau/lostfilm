//
//  AlertPresentingController.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 23.12.22.
//

import UIKit

public enum ToastConstraint {
    case xAxisConstraint, yAxisConstraint
}

public enum ToastPosition {
    case top, center, bottom

    fileprivate func setupPosition(toast: UIButton, superview: UIView) -> [ToastConstraint: NSLayoutConstraint] {
        let xAxisConstraint = toast.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let yAxisConstraint: NSLayoutConstraint

        switch self {
        case .top:
            yAxisConstraint = toast.topAnchor.constraint(equalTo: superview.topAnchor, constant: -(superview.safeAreaInsets.top + toast.bounds.height))
        case .center:
            yAxisConstraint = toast.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 0)
        case .bottom:
            yAxisConstraint = toast.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: (superview.safeAreaInsets.bottom + toast.bounds.height))
        }

        NSLayoutConstraint.activate([
            xAxisConstraint, yAxisConstraint
        ])

        return [.xAxisConstraint: xAxisConstraint, .yAxisConstraint: yAxisConstraint]
    }
}

class AlertPresentingController: UIViewController {
    let toast: UIButton
    var toastPosition: ToastPosition
    var toastConstraints: [ToastConstraint: NSLayoutConstraint]?
    weak var windowDelegate: AlertWindowProtocol?
    var topConstraint: NSLayoutConstraint!
    var centerXConstraint: NSLayoutConstraint!
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    //        let screenHeight: CGFloat! = view.window?.windowScene?.screen.bounds.height
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private var dismissalTimer: Timer?

    init(alertButton: UIButton, position: ToastPosition) {
        self.toast = alertButton
        toastPosition = position
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        view.addSubview(toast)

        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.isUserInteractionEnabled = true
        toast.addTarget(self, action: #selector(DidTapToast), for: .touchUpInside)

        toastConstraints = toastPosition.setupPosition(toast: toast, superview: view)

//        topConstraint = toast.topAnchor.constraint(equalTo: view.topAnchor, constant: -screenHeight / 10)
//        centerXConstraint = toast.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        NSLayoutConstraint.activate([
//            topConstraint, centerXConstraint
//        ])
    }

    func preRenderingPosition(toast: UIButton, superview: UIView) {
//        topConstraint = alertButton.topAnchor.constraint(equalTo: view.topAnchor, constant: -screenHeight / 10)
//        centerXConstraint = alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        NSLayoutConstraint.activate([
//            topConstraint, centerXConstraint
//        ])
    }

    func appearingAnimation() {

    }

    func dismissingAnimation() {

    }

    override func viewDidAppear(_ animated: Bool) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.75) { [weak self] in
            guard let self = self else {
                return
            }

            self.topConstraint?.constant = self.screenHeight / 10
            self.view.layoutIfNeeded()
        }

        dismissalTimer?.invalidate()
        dismissalTimer = Timer(timeInterval: 1, repeats: false, block: { [weak self] timer in
            guard timer.isValid else {
                return
            }
            self?.DidTapToast()
        })
        RunLoop.current.add(dismissalTimer!, forMode: .common)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @objc func DidTapToast() {
//        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
//        var window: UIWindow? = UIApplication.shared.windows.first { $0 is AlertWindow }

        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.75, animations: { [weak self] in
            guard let self = self else {
                return
            }
            self.centerXConstraint.isActive = false
            self.toast.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: self.screenWidth + self.toast.bounds.width).isActive = true
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.windowDelegate?.dismissWindow()
        })
    }
}

//        var windowToClose: UIWindow
//        for window in view.window!.windowScene!.windows {
//            if !window.isKeyWindow {
//                windowToClose = window
//                break
//            }
//        }
//        view.window!.windowScene!.windows.map { !$0.isKeyWindow = nil }
