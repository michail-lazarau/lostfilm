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
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let viewModel: LoginViewModel
    private let emailView = TextFieldView()
    private let passwordView = TextFieldView()
    private let captchaTextView = UITextField()
    private let captchaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_imageIndicator?.stopAnimatingIndicator()
        return imageView
    }()

    private let screenLoadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private let alertController: UIAlertController = {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        let continueAction = UIAlertAction(title: "Continue", style: .default) { _ in
            // TODO: show Tabbarviewcontroller, dismiss LoginViewController
        }
        alertController.addAction(continueAction)
        return alertController
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.Titles.welcome
        label.textColor = UIColor(named: "themeColor")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
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

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        setupTextFields()
        setupStackView(withViews: [UIView(), emailView, passwordView, captchaTextView, loginButton, captchaImageView])
//        setupStackView(withViews: [UIView(), emailView, passwordView, loginButton])
        setupConstraints()
    }
    
    private func initialSetup() {
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
//        loginButton.addTarget(self, action: #selector(self.animateLoginButton(sender:)), for: .touchUpInside)
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
        viewModel.loginViewModelDelegate = self
        setupView()
        registerKeyboardNotification()
        initialSetup()
        setupConstraints()
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

                    stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8.0),
                    stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8.0),
                    stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40.0),
                    stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40.0),
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
        self.view.endEditing(true)
    }

    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func login() {
        viewModel.checkForCaptcha { [weak self] in
            guard let self = self, let email = self.emailView.textField.text, let password = self.passwordView.textField.text else {
                return
            }

            self.viewModel.login(eMail: email, password: password, captcha: self.captchaTextView.text)
        }
    }
}

extension LoginViewController: LoginViewProtocol {
    func showError(error: Error) {
        DispatchQueue.main.async {
            // TODO: localisation
            DispatchQueue.main.async { [weak self] in
                if let self = self {
                    self.alertController.message = error.localizedDescription
                    self.present(self.alertController, animated: true) {
                        // completion
                    }
                }
            }
        }
    }

    func prepareCaptchaToDisplay() {
        DispatchQueue.main.async { [weak captchaImageView] in
            captchaImageView?.sd_imageIndicator?.startAnimatingIndicator()
        }
    }

    func authorise(username: String) {
        // TODO: localisation
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                self.alertController.message = "Welcome, \(username)"
                self.present(self.alertController, animated: true) {
                    // completion
                }
            }
        }
    }

    func updateCaptcha(data: Data) {
        DispatchQueue.main.async { [weak self] in
            self?.captchaImageView.image = UIImage(data: data)
            self?.captchaImageView.sd_imageIndicator?.stopAnimatingIndicator()
        }
    }

    // FIXME: temporarily out of use
    func displayLoadingIndicator() {
        DispatchQueue.main.async { [weak screenLoadingSpinner] in
            guard let screenLoadingSpinner = screenLoadingSpinner else {
                return
            }
            if !screenLoadingSpinner.isAnimating {
                screenLoadingSpinner.startAnimating()
            }
        }
    }

    // FIXME: temporarily out of use
    func removeLoadingIndicator() {
        DispatchQueue.main.async { [weak screenLoadingSpinner] in
            guard let screenLoadingSpinner = screenLoadingSpinner else {
                return
            }
            if screenLoadingSpinner.isAnimating {
                screenLoadingSpinner.stopAnimating()
            }
        }
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
