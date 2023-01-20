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
    private let viewModel: RegistrationViewModelProtocol
    private var isRememberMeButtonSelected = false
    private var isCaptchaButtonSelected = false

    private lazy var nickNameView: TextFieldView  = {
        let view = TextFieldView()
        view.configureInputField(on: .nickname)
        return view
    }()

    private lazy var emailView: TextFieldView = {
        let view = TextFieldView()
        view.configureInputField(on: .email)
        return view
    }()

    private lazy var passwordView: TextFieldView = {
        let view = TextFieldView()
        view.configureInputField(on: .password)
        return view
    }()

    private lazy var repeatPasswordView: TextFieldView = {
        let view = TextFieldView()
        view.configureInputField(on: .repeatPassword)
        return view
    }()

    private lazy var readyButton: LostfilmButton  = {
        let button = LostfilmButton(title: Texts.Buttons.ready)
        button.indicator.color = .white
        return button
    }()

    private lazy var captchaView: CaptchaView = {
        let view = CaptchaView()
        return view
    }()

    private lazy var rememberMeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "checkmark.square")
        button.setDimensions(width: 25, height: 25)
        button.setTitle("Remember Me", for: .normal)
        button.setTitleColor(.button, for: .normal)
        button.layer.cornerRadius = 5
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        return button
    }()

    private lazy var linkTextView: UITextView = {
        let view  = UITextView()
        view.backgroundColor =  UIColor.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setDimensions(width: 0, height: 20)
        return view
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.textColor = UIColor(named: "color")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewReady(self)
        initialSetup()
        setupView()
        bindTextFields()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotification()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotification()
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
    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.setupSubViews(withViews: [UIView(), titleLabel, nickNameView, emailView, passwordView, repeatPasswordView, rememberMeButton, captchaView, linkTextView, readyButton])
        setupConstraints()
    }

    private func initialSetup() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        rememberMeButton.addTarget(self, action: #selector(rememberMeButtonPressed), for: .touchUpInside)
        readyButton.addTarget(self, action: #selector(captchaButtonPressed), for: .touchUpInside)
        captchaView.checkmarkButton.addTarget(self, action: #selector(captchaButtonPressed), for: .touchUpInside)
        linkTextView.delegate = self
        nickNameView.textField.delegate = self
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
        repeatPasswordView.textField.delegate = self
        nickNameView.textField.returnKeyType = .next
        emailView.textField.returnKeyType = .next
        passwordView.textField.returnKeyType = .next
        repeatPasswordView.textField.returnKeyType = .done
        linkTextView.hyperLink(originalText: Texts.RulesTexts.ruleLinkText, hyperLink: Texts.RulesTexts.hyperLink, urlString: Links.rules)
    }
}

// MARK: Extension
private extension RegistrationViewController {
    // MARK: UI functions

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
   func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    func removeKeyboardNotification() {
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

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func bindTextFields() {
        readyButton.isEnabled = false
        nickNameView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        emailView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        passwordView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        repeatPasswordView.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }

    // MARK: Logic
    func didChangeButtonStatus(niknameViewString: String, emailViewString: String, passwordViewString: String, repeatPasswordViewString: String, isCaptchaButtonSelected: Bool) {
        viewModel.checkButtonStatus(nicknameViewString: niknameViewString,
                                    emailViewString: emailViewString,
                                    passwordViewString: passwordViewString,
                                    repeatPasswordViewString: repeatPasswordViewString,
                                    isCaptchaButtonSelected: isCaptchaButtonSelected)
    }

    func didChangeInputNicknameTextField(nicknameViewString: String) {
        viewModel.didEnterNicknameTextFieldWithString(nicknameViewString: nicknameViewString)
    }

    func didChangeInputEmailTextField(emailViewString: String) {
        viewModel.didEnterEmailTextFieldWithString(emailViewString: emailViewString)
    }

    func didChangeInputPasswordTextField(passwordViewString: String) {
        viewModel.didEnterPasswordTextFieldWithString(passwordViewString: passwordViewString)
    }

    func didChangeInputRepeatPasswordTextField(repeatPasswordViewString: String, passwordViewString: String ) {
        viewModel.didEnterRepeatPasswordTextFieldWithString(repeatPasswordViewString: repeatPasswordViewString, passwordViewString: passwordViewString)
    }

    @objc func textFieldEditingChanged(sender: UITextField) {
        switch sender {
        case nickNameView.textField:
            didChangeInputNicknameTextField(nicknameViewString: nickNameView.textField.text ?? "")
        case emailView.textField:
            didChangeInputEmailTextField(emailViewString: emailView.textField.text ?? "")
        case passwordView.textField:
            didChangeInputPasswordTextField(passwordViewString: passwordView.textField.text ?? "")
        case repeatPasswordView.textField:
            didChangeInputRepeatPasswordTextField(repeatPasswordViewString: repeatPasswordView.textField.text ?? "", passwordViewString: passwordView.textField.text ?? "")
        default:
            nickNameView.textField.resignFirstResponder()
        }
        didChangeButtonStatus(niknameViewString: nickNameView.textField.text ?? "",
                              emailViewString: emailView.textField.text ?? "",
                              passwordViewString: passwordView.textField.text ?? "",
                              repeatPasswordViewString: repeatPasswordView.textField.text ?? "",
                              isCaptchaButtonSelected: isCaptchaButtonSelected)
    }

    @objc func rememberMeButtonPressed() {
        if isRememberMeButtonSelected {
            rememberMeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            rememberMeButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        isRememberMeButtonSelected.toggle()
    }

    @objc func captchaButtonPressed() {
        if isCaptchaButtonSelected {
            captchaView.checkmarkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            captchaView.checkmarkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        isCaptchaButtonSelected.toggle()
    }
}

extension RegistrationViewController: RegistrationViewProtocol {
    func setButtonEnabled(_ isEnable: Bool) {
        DispatchQueue.main.async { [weak readyButton] in
            readyButton?.isEnabled = isEnable
        }
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
        repeatPasswordView.setConfirmationState(with: confirmationMessage, color: color)
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
        repeatPasswordView.setErrorState(with: errorMessage, color: color)
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
        if  URL.absoluteString == Links.rules {
            UIApplication.shared.open(URL)
        }
        return false
        }
    }
