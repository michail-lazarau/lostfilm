//
//  ToastPresentingController.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 23.12.22.
//

import UIKit

class ToastPresentingController: UIViewController {
    let toast: UIButton
    var toastPosition: ToastPosition
    var toastConstraints: (xAxisConstraint: NSLayoutConstraint, yAxisConstraint: NSLayoutConstraint)?
    weak var windowDelegate: AlertWindowProtocol?
    private let screenHeight: CGFloat = UIScreen.main.bounds.height // view.window?.windowScene?.screen.bounds.height
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private var dismissalTimer: Timer?

    init(toast: UIButton, position: ToastPosition) {
        self.toast = toast
        toastPosition = position
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        view.addSubview(toast)

        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.isUserInteractionEnabled = true
        toast.addTarget(self, action: #selector(DidTapToast), for: .touchUpInside)

        activateConstraints(for: toast, superview: view)
    }

    private func activateConstraints(for toast: UIButton, superview: UIView) {
        // MARK: setting a toast's initial position (default: beyond boundaries)
        toast.sizeToFit()
        toastConstraints = toastPosition.setupPosition(toast: toast, superview: superview)
        guard let toastConstraints = toastConstraints else {
            return
        }

        NSLayoutConstraint.activate([
            toastConstraints.0, toastConstraints.1
        ])
    }

    // MARK: Make a delegate with default implementation
    func toastDidAppearWithAnimation(_ toast: ToastPresentingController, duration: TimeInterval) {
        view.layoutIfNeeded()
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else {
                return
            }

            self.toastConstraints?.yAxisConstraint.constant = self.screenHeight / 10
            self.view.layoutIfNeeded()
        }
    }

    // TODO: suspend timer if the button receive a long tap
    private func setupTimer(timeInterval: TimeInterval) {
        dismissalTimer?.invalidate()
        dismissalTimer = Timer(timeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            guard timer.isValid else {
                return
            }
            self?.DidTapToast()
        })
        RunLoop.current.add(dismissalTimer!, forMode: .common)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toastDidAppearWithAnimation(self, duration: 0.75)
        setupTimer(timeInterval: 3)
    }

    @objc func DidTapToast() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.75, animations: { [weak self] in
            guard let self = self else {
                return
            }
            self.toastConstraints?.xAxisConstraint.isActive = false
            self.toast.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: self.screenWidth + self.toast.bounds.width).isActive = true
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.windowDelegate?.dismissWindow()
        })
    }
}

//        UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
//        var window: UIWindow? = UIApplication.shared.windows.first { $0 is AlertWindow }

//        var windowToClose: UIWindow
//        for window in view.window!.windowScene!.windows {
//            if !window.isKeyWindow {
//                windowToClose = window
//                break
//            }
//        }
//        view.window!.windowScene!.windows.map { !$0.isKeyWindow = nil }

//    func didTimerSetup(timeInterval: TimeInterval, completeWhenFires: @escaping @Sendable (Timer) -> Void) {
//        dismissalTimer?.invalidate()
//        dismissalTimer = Timer(timeInterval: timeInterval, repeats: false, block: completeWhenFires)
//        RunLoop.current.add(dismissalTimer!, forMode: .common)
//    }

    //        didTimerSetup(timeInterval: 1) { [weak self] timer in
    //            guard timer.isValid else {
    //                return
    //            }
    //            Task { @MainActor [weak self] in
    //                self?.DidTapToast()
    //            }
    //        }
