//
//  RegistrationViewController.swift
//  lostfilm
//
//  Created by u.yanouski on 28/09/2022.
//

import Foundation

class RegistrationViewController: UIViewController {

    private let emailTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(emailTextField)
        emailTextField.testF(on: .password)
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])

    }
}
