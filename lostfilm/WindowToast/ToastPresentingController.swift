//
//  ToastPresentingController.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 23.12.22.
//

import UIKit

class ToastPresentingController: UIViewController, PresentingControllerProtocol {
    let toast: UIView
    var xAxisConstraint: NSLayoutConstraint?
    var yAxisConstraint: NSLayoutConstraint?

    lazy var maxWidthConstraint: NSLayoutConstraint? = {
        guard let maxWidth = toastManager.sizeLimits.maxWidthConstant[traitCollection.userInterfaceIdiom] else {
            return nil
        }
        return toast.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth)
    }()

    lazy var minWidthConstraint: NSLayoutConstraint? = {
        guard let minWidth = toastManager.sizeLimits.minWidthConstant[traitCollection.userInterfaceIdiom] else {
            return nil
        }
        return toast.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth)
    }()

    lazy var maxHeightConstraint: NSLayoutConstraint? = {
        guard let maxHeight = toastManager.sizeLimits.maxHeightConstant[traitCollection.userInterfaceIdiom] else {
            return nil
        }
        return toast.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight)
    }()

    lazy var minHeightConstraint: NSLayoutConstraint? = {
        guard let minHeight = toastManager.sizeLimits.minHeightConstant[traitCollection.userInterfaceIdiom] else {
            return nil
        }
        return toast.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight)
    }()

    let toastManager: ToastManager
    weak var windowDelegate: ToastWindowProtocol?

    var screen: UIScreen? {
        view.window?.windowScene?.screen
    }

    private var dismissalTimer: Timer?

    init(toast: UIView, toastManager: ToastManager) {
        self.toast = toast
        self.toastManager = toastManager
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
//        toast.sizeToFit()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapToast))
        toast.addGestureRecognizer(gesture)
        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.isUserInteractionEnabled = true
        setupPosition(toastManager.prePosition, toast: toast, superview: view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activateToastSizeLimitingConstraints()
        toastDidAppearWithAnimation(self, duration: toastManager.appearingDuration)
        setupTimer(timeInterval: toastManager.autohideDuration)
    }

    func setupPosition(_ position: ToastPosition?, toast: UIView, superview: UIView) {
        guard let position = position else {
            return
        }

        if let xAxisConstraint = xAxisConstraint, let yAxisConstraint = yAxisConstraint {
            NSLayoutConstraint.deactivate([xAxisConstraint, yAxisConstraint])
        }

        (xAxisConstraint, yAxisConstraint) = position.setupConstraints(toast: toast, superview: superview)

        if let xAxisConstraint = xAxisConstraint, let yAxisConstraint = yAxisConstraint {
            NSLayoutConstraint.activate([xAxisConstraint, yAxisConstraint])
        }
    }

    // MARK: Make a delegate with default implementation

    func toastDidAppearWithAnimation(_ toastPresentingController: ToastPresentingController, duration: TimeInterval) {
        view.layoutIfNeeded()
        toast.alpha = 0.0

        setupPosition(self.toastManager.playPosition, toast: self.toast, superview: self.view)
        UIView.animate(withDuration: duration) { [weak self] in
            guard let self = self else {
                return
            }
            self.toast.alpha = 1.0
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
            self?.didTapToast()
        })

        RunLoop.current.add(dismissalTimer!, forMode: .common)
    }

    // MARK: constraints initialisation relies on the screen.bounds property, which is accessible since the 'viewDidAppear' step
    private func activateToastSizeLimitingConstraints() {
        minWidthConstraint?.isActive = true
        maxWidthConstraint?.isActive = true
        minHeightConstraint?.isActive = true
        maxHeightConstraint?.isActive = true
    }

    @objc func didTapToast() {
        view.layoutIfNeeded()
        setupPosition(toastManager.postPosition, toast: toast, superview: view)
        UIView.animate(withDuration: toastManager.disappearingDuration, animations: { [weak self] in
            guard let self = self else {
                return
            }

            self.toast.alpha = 0.0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.windowDelegate?.dismissWindow()
        })
    }
}
