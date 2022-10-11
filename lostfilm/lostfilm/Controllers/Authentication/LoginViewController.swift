//
//  LoginVC.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation
import UIKit
//import SDWebImage

final class LoginViewController: UIViewController, LoginViewProtocol {
    let emailView = TextFieldView()
    let passwordView = TextFieldView()
    private let captchaTextView = TextFieldView()
    private let captchaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.clipsToBounds = true
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

        stackView.anchor(top: scrollView.contentLayoutGuide.topAnchor, left: scrollView.contentLayoutGuide.leftAnchor, bottom: scrollView.contentLayoutGuide.bottomAnchor, right: scrollView.contentLayoutGuide.rightAnchor)
        stackView.equalWidth(width: scrollView.widthAnchor)

        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func login() {
        // TODO: call LoginViewModel.getLoginPage
        viewModel.checkLoginPageForCaptcha { [weak self] in
            guard let strongSelf = self, let email = strongSelf.emailView.textField.text, let password = strongSelf.passwordView.textField.text else {
                return
            }

            strongSelf.viewModel.login(eMail: email, password: password, captcha: strongSelf.captchaTextView.textField.text)
        }
    }
}

// MARK: LoginViewControllerDelegate
extension LoginViewController {
    func showError(error: Error) {
//        DispatchQueue.main.async {
            // TODO: Tost alert
//        }
    }

    func authorise(username: String) {
//        DispatchQueue.main.async {
            // TODO: show Tabbarviewcontroller, dismiss LoginViewController
//        }
    }

    func updateCaptcha(url: URL) {
        // TODO: add a spinner to SDWebImage
//        DispatchQueue.main.async { [weak captchaImageView] in
            captchaImageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
//        }

//        SDImageCache.shared.removeImage(forKey: url.description)

//        captchaImageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached) { [weak self] image, error, cacheType, url in
//            captchaImageView?.image = image
//        }
    }

    // FIXME: move it to LVC from the Delegate?
    func displayUIActivityIndicator() {
        if !screenLoadingSpinner.isAnimating {
            screenLoadingSpinner.startAnimating()
        }
    }

    func removeUIActivityIndicator() {
//        DispatchQueue.main.async { [weak screenLoadingSpinner] in
//            guard let screenLoadingSpinner = screenLoadingSpinner else {
//                return
//            }
            if screenLoadingSpinner.isAnimating {
                screenLoadingSpinner.stopAnimating()
            }
//        }
    }
}
