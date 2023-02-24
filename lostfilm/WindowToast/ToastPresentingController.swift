//
//  ToastPresentingController.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 23.12.22.
//

import UIKit

class ToastPresentingController: UIViewController {
    let toast: UIView
    var xAxisConstraint: NSLayoutConstraint?
    var yAxisConstraint: NSLayoutConstraint?
    var constantWidthConstraint: NSLayoutConstraint?
    var constantHeightConstraint: NSLayoutConstraint?

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

        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapToast))
        toast.addGestureRecognizer(gesture)
        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.isUserInteractionEnabled = true
        toast.alpha = 0.0
        activateToastSizeLimitingConstraints()
        setupPosition(toastManager.prePosition, toast: toast, superview: view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toastDidAppearWithAnimation(self, duration: toastManager.appearingDuration)
        setupTimer(timeInterval: toastManager.autohideDuration)
    }

//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//    }

//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        <#code#>
//    }

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

    func toastDidAppearWithAnimation(_ toastPresentingController: ToastPresentingController, duration: TimeInterval) {
        view.layoutIfNeeded()
        setupPosition(toastManager.playPosition, toast: toast, superview: view)

        UIView.animate(withDuration: duration) { [weak self, toastManager] in
            guard let self = self else {
                return
            }
            self.toast.alpha = 1.0
            if toastManager.prePosition != nil {
                self.view.layoutIfNeeded()
            }
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

    private func activateToastSizeLimitingConstraints() {
        if let constantWidthConstraint = constantWidthConstraint {
            constantWidthConstraint.isActive = true
        } else {
            minWidthConstraint?.isActive = true
            maxWidthConstraint?.isActive = true
        }
        if let constantHeightConstraint = constantHeightConstraint {
            constantHeightConstraint.isActive = true
        } else {
            minHeightConstraint?.isActive = true
            maxHeightConstraint?.isActive = true
        }
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
