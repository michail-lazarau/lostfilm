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
    weak var windowDelegate: ToastWindowProtocol?
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
        toastPosition.setupPosition(toast: toast, superview: view, isActivated: true)

//        activateConstraints(for: toast, superview: view)
//        let cView = UIView(frame: .zero)
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(DidTapToast))
//        cView.addGestureRecognizer(gesture)
    }

    func didMoveToAppear(constraints: (xAxisConstraint: NSLayoutConstraint, yAxisConstraint: NSLayoutConstraint)) {
    }

    func didMoveToDisappear(constraints: (xAxisConstraint: NSLayoutConstraint, yAxisConstraint: NSLayoutConstraint)) {

    }

    // MARK: Make a delegate with default implementation
    func toastDidAppearWithAnimation(_ toastPresentingController: ToastPresentingController, duration: TimeInterval) {
        view.layoutIfNeeded()
        toast.alpha = 0.0

        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else {
                return
        }
            self.toast.alpha = 1.0

            // activate
            self.toastPosition.yAxisConstraint?.constant = self.screenHeight / 10
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
        // MARK: check out timer modes
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
            self.toastPosition.xAxisConstraint?.isActive = false
//            self.toastConstraints?.xAxisConstraint.isActive = false
            self.toast.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: self.screenWidth + self.toast.bounds.width).isActive = true
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.windowDelegate?.dismissWindow()
        })
    }
}

// MARK: setting a toast's initial position (default: beyond boundaries)
//        if !UIDevice.current.hasNotch { // makes difference if alpha is 1.0 in the beginning of animation
//            toast.sizeToFit()
//        }

//        let size = self.view.systemLayoutSizeFitting(self.toast.frame.size) // delete
//        let finalSize = toast.frame.size
//        toast.frame.size.width = 227 - 40 // notch width for 'iPhone 12 mini' without rounding along the edges.
//        toast.frame.size.height = 0 // delete

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
