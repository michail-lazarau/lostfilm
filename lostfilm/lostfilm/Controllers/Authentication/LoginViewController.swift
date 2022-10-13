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
    let view2 = TextFieldView()
    let view3 = TextFieldView()
    let view4 = TextFieldView()
    let view5 = TextFieldView()
    let view6 = TextFieldView()
    let view7 = TextFieldView()
    let view8 = TextFieldView()
    let view9 = TextFieldView()
    let view10 = TextFieldView()
    let view11 = TextFieldView()
    let view12 = TextFieldView()
    let view13 = TextFieldView()
    let view14 = TextFieldView()
    let view15 = TextFieldView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.Titles.welcome
        label.textColor = UIColor(named: "themeColor")
        label.textAlignment = .center
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Texts.Buttons.locString, for: .normal)
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
        setupStackView(withViews: [UIView(),
                                   emailView,
                                   passwordView,
                                   view2,
                                   view3,
                                   view4,
                                   view5,
                                   view6,
                                   view7,
                                   view8,
                                   view9,
                                   view10,
                                   view11,
                                   view12,
                                   view13,
                                   view14,
                                   view15,


                                   loginButton])
        setupConstraints()
    }

    private func initialSetup() {
        loginButton.addTarget(self, action: #selector(self.animateLoginButton(sender:)), for: .touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
    }

    @objc  fileprivate func animateLoginButton(sender: UIButton) {
        self.animateView(sender)
    }

    func animateView(_ viewToAnimate: UIView) {
        UIView.animate( withDuration: 0.25,
                        delay: 0,
                        usingSpringWithDamping: 1,
                        initialSpringVelocity: 1,
                        options: .curveEaseOut) {

            viewToAnimate.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        } completion: { _ in
            UIView.animate( withDuration: 0.25,
                            delay: 0,
                            usingSpringWithDamping: 0.4,
                            initialSpringVelocity: 2,
                            options: .curveEaseIn,
                            animations: {

                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
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
        view2.configureInputField(on: .nickname)
        view3.configureInputField(on: .nickname)
        view5.configureInputField(on: .nickname)
        view5.configureInputField(on: .nickname)
        view6.configureInputField(on: .nickname)
        view7.configureInputField(on: .nickname)
        view8.configureInputField(on: .nickname)
        view9.configureInputField(on: .nickname)
        view10.configureInputField(on: .nickname)
        view11.configureInputField(on: .nickname)
    }

    func setupStackView(withViews view: [UIView]) {
        for view in view {
            stackView.addArrangedSubview(view)
        }
    }

    func setupConstraints() {
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        titleLabel.anchor(top: scrollView.contentLayoutGuide.topAnchor, left: scrollView.contentLayoutGuide.leftAnchor, bottom: stackView.topAnchor, right: scrollView.contentLayoutGuide.rightAnchor, paddingTop: 100)
        stackView.anchor(top: titleLabel.bottomAnchor, left: scrollView.contentLayoutGuide.leftAnchor,  right: scrollView.contentLayoutGuide.rightAnchor)
        stackView.equalWidth(width: scrollView.widthAnchor)
    }

    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
       guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
       else { return }

       let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
       scrollView.contentInset = contentInsets
       scrollView.scrollIndicatorInsets = contentInsets
     }

     @objc func keyboardWillHide(notification: NSNotification) {
       let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

       scrollView.contentInset = contentInsets
       scrollView.scrollIndicatorInsets = contentInsets
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
