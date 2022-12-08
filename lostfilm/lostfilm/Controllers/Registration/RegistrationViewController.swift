//
//  RegistrationViewController.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-02.
//

import Foundation
import UIKit

final class RegistrationViewController: UIViewController {
    // MARK: Variables
    private let viewModel: RegistrationViewModel
    private let nickNameView = TextFieldView()
    private let emailView = TextFieldView()
    private let passwordView = TextFieldView()
    private let repeatPasswordView = TextFieldView()
    private let linkURL = "https://www.apple.com"

    private let readyButton: LostfilmButton  = {
        let button = LostfilmButton(title: Texts.Buttons.ready)
        button.indicator.color = .white
        return button
    }()

    private let linkTextView: UITextView = {
        let view  = UITextView()
        view.backgroundColor =  UIColor.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setDimensions(width: 0, height: 20) // уточинть как тут лучше сделать тк высталнеие ширины не имеет значение
        return view
    }()

    private let captchaView: UIView = {
        let view = UIView()
        view.backgroundColor = . red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "LABEL TEST"
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

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        initialSetup()
        setupView()
        bindTextFields()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: Inits
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions
    func setupView() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        setupTextFields()
        setupStackView(withViews: [UIView(), titleLabel, nickNameView, emailView, passwordView, repeatPasswordView, readyButton, linkTextView])
        setupConstraints()
    }

    func initialSetup() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        linkTextView.delegate = self
        nickNameView.textField.delegate = self
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
        repeatPasswordView.textField.delegate = self
        nickNameView.textField.returnKeyType = .next
        emailView.textField.returnKeyType = .next
        passwordView.textField.returnKeyType = .next
        repeatPasswordView.textField.returnKeyType = .done
        linkTextView.hyperLink(originalText: "To find out more please visit our website", hyperLink: "website", urlString: linkURL)
    }
}

// MARK: Extension
extension RegistrationViewController {
    // MARK: UI functions
    func setupTextFields() {
        nickNameView.configureInputField(on: .name)
        emailView.configureInputField(on: .email)
        passwordView.configureInputField(on: .password)
        repeatPasswordView.configureInputField(on: .repeatPassword)
    }

    func setupStackView(withViews views: [UIView]) {
        for view in views {
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

    // MARK: Keyboard

    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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

    private func bindTextFields() {
        readyButton.isEnabled = false
        nickNameView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        emailView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        passwordView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        repeatPasswordView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }

    // MARK: Logic

    private func didChangeButtonStatus() {}

    private func didChangeInputNicknameTextField(nicknameViewString: String) {
        viewModel.didEnterNicknameTextFieldWithString(nicknameViewString: nicknameViewString)
    }

    private func didChangeInputEmailTextField(emailViewString: String) {
        viewModel.didEnterEmailTextFieldWithString(emailViewString: emailViewString)
    }

    private func didChangeInputPasswordTextField(passwordViewString: String) {
        viewModel.didEnterPasswordTextFieldWithString(passwordViewString: passwordViewString)
    }

    private func didChangeInputRepeatPasswordTextField(repeatPasswordViewString: String) {}

    @objc func textFieldEditingChanged(sender: UITextField) {
        if sender == nickNameView.textField {
            didChangeInputNicknameTextField(nicknameViewString: nickNameView.textField.text ?? "")
        } else if sender == emailView.textField {
            didChangeInputEmailTextField(emailViewString: emailView.textField.text ?? "")
        } else if sender == passwordView.textField {
            didChangeInputPasswordTextField(passwordViewString: passwordView.textField.text ?? "")
        }
    }
}

extension RegistrationViewController: RegistrationViewProtocol {
    func setButtonEnabled(_ isEnable: Bool) {
        print("")
    }

    func sendNicknameConformationMessage(_ confirmationMessage: String, color: UIColor) {
        nickNameView.setConfirmationState(with: confirmationMessage, color: color)
    }

    func sendEmailConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        emailView.setConfirmationState(with: confirmationMessage, color: color)
    }

    func sendPasswordConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        passwordView.setConfirmationState(with: confirmationMessage, color: color)
    }

    func sendRepeatPasswordConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        print("")
    }

    func sendNicknameErrorMessage(_ errorMessage: String, color: UIColor) {
        nickNameView.setErrorState(with: errorMessage, color: color)
    }

    func sendEmailErrorMessage(_ errorMessage: String, color: UIColor) {
        emailView.setErrorState(with: errorMessage, color: color)
    }

    func sendPasswordErrorMessage(_ errorMessage: String, color: UIColor) {
        passwordView.setErrorState(with: errorMessage, color: color)
    }

    func sendRepeatPasswordErrorMessage(_ errorMessage: String, color: UIColor) {
        print("")
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nickNameView.textField:
            emailView.textField.becomeFirstResponder()
        case emailView.textField:
            passwordView.textField.becomeFirstResponder()
        case passwordView.textField:
            repeatPasswordView.textField.becomeFirstResponder()
        case repeatPasswordView.textField:
            hideKeyboard()
        default:
            nickNameView.textField.resignFirstResponder()
        }
        return true
    }
}

extension RegistrationViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if  URL.absoluteString == linkURL {
            UIApplication.shared.open(URL)
        }
        return false
        }
    }
