//
//  AlertPresentingController.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 23.12.22.
//

import UIKit

class AlertPresentingController: UIViewController {
    let alertButton: UIButton

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
        alertButton.addTarget(self, action: #selector(tap), for: .touchUpInside)

        let screenHeight: CGFloat = UIScreen.main.bounds.height
//        let screenHeight: CGFloat! = view.window?.windowScene?.screen.bounds.height
        let top = alertButton.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight / 5)
        let centerX = alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([
            top, centerX
        ])
    }

    @objc func tap() {
        print("Tap alertWindow button")
    }
}
