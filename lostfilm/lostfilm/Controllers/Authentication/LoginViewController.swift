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
        label.text = Texts.Titles.welcome
        label.textColor = UIColor(named: "themeColor")
        label.textAlignment = .center
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Texts.Buttons.logIn, for: .normal)
        button.backgroundColor = UIColor(named: "themeColor")
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

    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setupTextFields()
        setupStackView(withViews: [UIView(), emailView, passwordView, loginButton])
        setupConstraints()
    }

    private func initialSetup() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
    }

    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.emailView:
            self.emailView.textField.becomeFirstResponder()
        case self.passwordView:
            self.passwordView.textField.becomeFirstResponder()
        default:
            self.emailView.textField.becomeFirstResponder()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerKeyboardNotification()
        initialSetup()
    }
    deinit {
        removeKeyboardNotification()
    }
}



extension LoginViewController {

    func setupTextFields() {
        emailView.configureInputField(on: .name)
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

    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight / 4)
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if emailView.textField == textField {
            passwordView.textField.becomeFirstResponder()
        }
        return true
    }
}
