//
//  LoginVC.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    private let emailView = TextFieldView()
    private let passwordView = TextFieldView()
    private let loginButton = LostfilmButton(title: Texts.Buttons.buttonLogIn)

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(Texts.Titles.logIn, comment: "")
        label.textColor = UIColor(named: "color")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        stackView.spacing = 20
        return stackView
    }()

    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        setupTextFields()
        setupStackView(withViews: [UIView(), titleLabel, emailView, passwordView, loginButton])
        setupConstraints()
    }

    private func initialSetup() {
        loginButton.addTarget(self, action: #selector(self.animateLoginButton(sender:)), for: .touchDown)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
        emailView.textField.returnKeyType = .next
        passwordView.textField.returnKeyType = .done
    }

    @objc fileprivate func animateLoginButton(sender: UIButton) {
        sender.setBackgroundColor(.lightGray, for: .highlighted)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerKeyboardNotification()
        initialSetup()
        setupConstraints()
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
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0.0)
        contentViewHeightConstraint.priority = .defaultLow

        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.safeAreaLayoutGuide.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.safeAreaLayoutGuide.rightAnchor)

        contentView.anchor(top: scrollView.contentLayoutGuide.topAnchor,
                           left: scrollView.contentLayoutGuide.leftAnchor,
                           bottom: scrollView.contentLayoutGuide.bottomAnchor,
                           right: scrollView.contentLayoutGuide.rightAnchor)

        NSLayoutConstraint.activate([

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0.0),

            stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Paddings.top),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: Paddings.bottom),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Paddings.left),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Paddings.right),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0),

            contentViewHeightConstraint
        ])
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

      let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)

      scrollView.contentInset = contentInsets
      scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

      scrollView.contentInset = contentInsets
      scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailView.textField == textField {
            passwordView.textField.becomeFirstResponder()
        }
        if passwordView.textField == textField {
            hideKeyboard()
        }
        return true
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    color.setFill()
    UIRectFill(rect)
    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    setBackgroundImage(colorImage, for: state)
  }
}
