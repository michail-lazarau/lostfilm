//
//  LoginVC.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation
import SDWebImage
import UIKit

final class LoginViewController: UIViewController, LoginViewProtocol {
    let emailView = TextFieldView()
    let passwordView = TextFieldView()
    private let captchaTextView = UITextField()
    private let captchaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_imageIndicator?.stopAnimatingIndicator()
        return imageView
    }()

    private let viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Texts.logIn, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
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
        view.backgroundColor = .gray
        viewModel.loginViewModelDelegate = self
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setupTextFields()
        setupStackView(withViews: [UIView(), emailView, passwordView, captchaTextView, loginButton, captchaImageView])
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

        stackView.anchor(top: scrollView.contentLayoutGuide.topAnchor, left: scrollView.contentLayoutGuide.leftAnchor, bottom: scrollView.contentLayoutGuide.bottomAnchor, right: scrollView.contentLayoutGuide.rightAnchor)
        stackView.equalWidth(width: scrollView.widthAnchor)

        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
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

// MARK: LoginViewControllerDelegate

extension LoginViewController {
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
