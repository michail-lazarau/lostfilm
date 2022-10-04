//
//  LoginVC.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    private lazy var emailContainerView: UIView = {
        let image = Icons.mailIcon
        let view = Utilities().createInputContainerView(withImage: Icons.mailIcon, textField: emailTextField)
        return view
    }()

    private lazy var passwordContainerView: UIView = {
        let view = Utilities().createInputContainerView(withImage: Icons.passwordIcon, textField: passwordTextField)
        return view
    }()

    private let emailTextField: UITextField = {
        let textField = Utilities().createTextField(withPlaceholder: Texts.email)
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = Utilities().createTextField(withPlaceholder: Texts.password)
        return textField
    }()

    private let passwordField = CustomTextField()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Texts.logIn, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        return button
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.setupPasswordInputView()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setupStackView(withViews: [UIView(), emailContainerView, passwordContainerView, loginButton, passwordField])
        setupConstraints()
    }
}

extension LoginViewController {
    func setupStackView(withViews view: [UIView]) {
        for view in view {
            stackView.addArrangedSubview(view)
        }
    }

    func setupConstraints() {
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)

        stackView.anchor(top: scrollView.contentLayoutGuide.topAnchor, left: scrollView.contentLayoutGuide.leftAnchor, bottom: scrollView.contentLayoutGuide.bottomAnchor, right: scrollView.contentLayoutGuide.rightAnchor)
        stackView.equalWidth(width: scrollView.widthAnchor)

        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
