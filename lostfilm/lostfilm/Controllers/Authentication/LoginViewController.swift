//
//  LoginVC.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation
import SDWebImage
import UIKit

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    private let emailView = TextFieldView()
    private let passwordView = TextFieldView()
    private let captchaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_imageIndicator?.stopAnimatingIndicator()
        return imageView
    }()

    private let loginButton: LostfilmButton = {
        let button = LostfilmButton(title: Texts.Buttons.buttonLogIn)
        button.indicator.color = .white
        return button
    }()

    private let captchaTextView: TextFieldView = {
        let view = TextFieldView()
        view.textField.keyboardType = .numberPad
        view.textField.addDoneCancelToolbar()
        view.isHidden = true
        return view
    }()

    private var alertController: UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .default) { _ in
            // TODO: show Tabbarviewcontroller, dismiss LoginViewController
        }
        alertController.addAction(continueAction)
        return alertController
    }

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

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        setupTextFields()
        setupStackView(withViews: [UIView(), titleLabel, emailView, passwordView, captchaImageView, captchaTextView, loginButton])
        setupConstraints()
    }

    private func initialSetup() {
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
        emailView.textField.returnKeyType = .next
        passwordView.textField.returnKeyType = .done
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loginViewModelDelegate = self
        setupView()
        setupAddTargetIsNotEmptyTextFields()
        registerKeyboardNotification()
        initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotification()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotification()
    }
}

extension LoginViewController {
    func setupTextFields() {
        emailView.configureInputField(on: .name)
        passwordView.configureInputField(on: .password)
        captchaTextView.configureInputField(on: .captcha)
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

    private func setupAddTargetIsNotEmptyTextFields() {
        loginButton.isEnabled = false
        emailView.textField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        passwordView.textField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }

    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        viewModel.checkTF(sender: sender, emailView: emailView, passwordView: passwordView, button: loginButton)
      }

    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func login(_ sender: LoadingButton) {
        sender.showLoader(userInteraction: false)
        if let email = emailView.textField.text, let password = passwordView.textField.text {
            viewModel.login(email: email, password: password, captcha: captchaTextView.textField.text)
        }
    }
}

extension LoginViewController: LoginViewProtocol {
    func removeLoadingIndicator() {
        DispatchQueue.main.async { [weak loginButton] in
            loginButton?.hideLoader()
        }
    }

    func showError(error: Error) {
        // TODO: localisation
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                // MARK: should self.loginButton.hideLoader() be put instead of removeLoadingIndicator() delegate func?

                let alert = self.alertController
                alert.message = error.localizedDescription
                self.present(alert, animated: true) {
                    // completion
                }
            }
        }
    }

    func prepareCaptchaToUpdate() {
        DispatchQueue.main.async { [weak captchaImageView] in
            if captchaImageView?.image != nil {
                captchaImageView?.sd_imageIndicator?.startAnimatingIndicator()
            }
        }
    }

    func updateCaptcha(data: Data) {
        DispatchQueue.main.async { [weak captchaTextView, captchaImageView] in

            // MARK: should self.loginButton.hideLoader() be put instead of removeLoadingIndicator() delegate func?

            captchaTextView?.isHidden = false
            captchaImageView.image = UIImage(data: data)
            captchaImageView.sd_imageIndicator?.stopAnimatingIndicator()
        }
    }

    func hideCaptchaWhenFailedToLoad() {
        DispatchQueue.main.async { [weak captchaTextView, captchaImageView] in
            captchaTextView?.isHidden = true
            captchaImageView.image = nil
            captchaImageView.sd_imageIndicator?.stopAnimatingIndicator()
        }
    }

    func authorise(username: String) {
        // TODO: localisation
        DispatchQueue.main.async { [weak self] in

            // MARK: should self.loginButton.hideLoader() be put instead of removeLoadingIndicator() delegate func?

            if let self = self {
                let alert = self.alertController
                alert.message = "Welcome, \(username)"
                self.present(self.alertController, animated: true) {
                    // completion
                }
            }
        }
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
