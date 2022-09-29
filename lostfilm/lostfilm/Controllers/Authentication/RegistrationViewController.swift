//
//  RegistrationViewController.swift
//  lostfilm
//
//  Created by u.yanouski on 28/09/2022.
//

import Foundation

class RegistrationViewController: UIViewController {

    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(title: "EMAIL")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(emailTextField)

        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])

    }
}
