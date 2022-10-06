//
//  LoginVC.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {

    let emailView = TextFieldView()
    let passwordView = TextFieldView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.Titles.logIn
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Texts.Buttons.logIn, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        return button
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setupTextFields()
        setupStackView(withViews: [UIView(), emailView, passwordView, loginButton])
        setupConstraints()
    }
}

extension LoginViewController {

    func setupTextFields() {
        emailView.configureInputField(on: .email)
        passwordView.configureInputField(on: .password)
    }

    func setupStackView(withViews view: [UIView]) {
        for view in view {
            stackView.addArrangedSubview(view)
        }
    }

    func setupConstraints() {
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        titleLabel.anchor(top: scrollView.contentLayoutGuide.topAnchor, left: scrollView.contentLayoutGuide.leftAnchor, bottom: stackView.topAnchor, right: scrollView.contentLayoutGuide.rightAnchor, paddingTop: 100)
        stackView.anchor(top: titleLabel.bottomAnchor, left: scrollView.contentLayoutGuide.leftAnchor, bottom: scrollView.contentLayoutGuide.bottomAnchor, right: scrollView.contentLayoutGuide.rightAnchor)
        stackView.equalWidth(width: scrollView.widthAnchor)
        loginButton.centerY(inView: scrollView)
    }
}
