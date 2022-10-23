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
    private let loginButton = LostfilmButton()
    private let emailView = TextFieldView()
    private let passwordView = TextFieldView()
    private let captchaTextView: TextFieldView = {
        let view = TextFieldView()
        view.textField.keyboardType = .numberPad
        view.textField.addDoneCancelToolbar()
        view.isHidden = true
        return view
    }()

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
        label.text = NSLocalizedString(Texts.Titles.logIn, comment: "")
        label.textColor = UIColor(named: "color")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //    private let loginButton: UIButton = {
    //  let button = UIButton(type: .system)
//        button.backgroundColor = UIColor(named: "themeColor")
    //  button.setTitle(Texts.Buttons.buttonLogIn, for: .normal)
    //  button.setBackgroundColor(.red, for: .selected)
    //  button.layer.cornerRadius = 5
    //  button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    //  button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    //  return button
    // }()

//    override open var isHighlighted: Bool {
//        didSet {
//            backgroundColor = isHighlighted ? UIColor.black : UIColor.white
//        }
//    }

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
//        loginButton.addTarget(self, action: #selector(self.animateLoginButton(sender:)), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        emailView.textField.delegate = self
        passwordView.textField.delegate = self
    }

    @objc fileprivate func animateLoginButton(sender: UIButton) {
        sender.setBackgroundColor(.lightGray, for: .highlighted)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loginViewModelDelegate = self
        setupView()
        initialSetup()
        setupConstraints()
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

    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func login() {
        if let email = emailView.textField.text, let password = passwordView.textField.text {
                viewModel.login(email: email, password: password, captcha: captchaTextView.textField.text)
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
            self?.captchaTextView.isHidden = false
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
