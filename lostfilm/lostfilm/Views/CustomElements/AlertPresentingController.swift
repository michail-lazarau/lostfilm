//
//  AlertPresentingController.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 23.12.22.
//

import UIKit

class AlertPresentingController: UIViewController {
    let alertButton: UIButton
    weak var windowDelegate: AlertWindowProtocol?
    var topConstraint: NSLayoutConstraint!
    var centerXConstraint: NSLayoutConstraint!
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    //        let screenHeight: CGFloat! = view.window?.windowScene?.screen.bounds.height
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private var dismissalTimer: Timer?

    init(alertButton: UIButton) {
        self.alertButton = alertButton
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
        view.addSubview(alertButton)

        alertButton.translatesAutoresizingMaskIntoConstraints = false
        alertButton.isUserInteractionEnabled = true
        alertButton.addTarget(self, action: #selector(DidTapToast), for: .touchUpInside)

        topConstraint = alertButton.topAnchor.constraint(equalTo: view.topAnchor, constant: -screenHeight / 10)
        centerXConstraint = alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([
            topConstraint, centerXConstraint
        ])
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
            self.alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: self.screenWidth + self.alertButton.bounds.width).isActive = true
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
