//
//  CustomTextField.swift
//  lostfilm
//
//  Created by u.yanouski on 28/09/2022.
//

import UIKit

// MARK: File Private Variables

final class TextFieldView: UIView {

    // MARK: Variabels

    var isButtonSelected = false

    enum CustomFields {
        case email
        case password
        case repeatPassword
        case nickname
        case name
        case surname
        case captcha
    }

    // MARK: Subviews

    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 5
        textField.textAlignment  = .natural
        return textField
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.textColor = UIColor(named: "other")
        return titleLabel
    }()

    var textFieldIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var passwordButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "eye.slash")
        button.layer.cornerRadius = 5
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(passwordButtonPressed), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()

    private let contentView = UIView()
    private var dividerView = UIView()
    var errorLabel = UILabel()

    // MARK: Inits

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(textFieldIcon)
        setupContentView()
        stackView.setupSubViews(withViews: [titleLabel, contentView])
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    func hidePassword() {
        textField.isSecureTextEntry = false
    }

    func showPassword() {
        textField.isSecureTextEntry = true
    }

    @objc func passwordButtonPressed() {
        if isButtonSelected {
            passwordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            hidePassword()
        } else {
            showPassword()
            passwordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        isButtonSelected.toggle()
    }
}

    // MARK: Extension

extension TextFieldView {

    func setupContentView() {
        contentView.addSubview(dividerView)
        contentView.addSubview(textField)
        contentView.addSubview(passwordButton)
        contentView.addSubview(textFieldIcon)
        contentView.addSubview(errorLabel)
    }

    func setupPasswordInputView(withImage image: UIImage, withTitleLabel title: String, withPlaceholder placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textFieldIcon.image = image

        textField.anchor(top: contentView.topAnchor, left: textFieldIcon.rightAnchor, bottom: contentView.bottomAnchor, right: passwordButton.leftAnchor)
        passwordButton.anchor(top: contentView.topAnchor, left: textField.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        textFieldIcon.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: textField.leftAnchor)

        dividerView.backgroundColor = UIColor.dividedView
        dividerView.anchor(top: textFieldIcon.bottomAnchor, left: textFieldIcon.rightAnchor, bottom: errorLabel.topAnchor, right: passwordButton.leftAnchor, height: 0.75)

        errorLabel.anchor(top: dividerView.bottomAnchor, left: textFieldIcon.rightAnchor, right: passwordButton.leftAnchor)

        textFieldIcon.setDimensions(width: 25, height: 25)
        passwordButton.setDimensions(width: 25, height: 25)

        textField.isSecureTextEntry = true
    }

    func setupCommonInputView(withImage image: UIImage, withTitleLabel title: String, withPlaceholder placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textFieldIcon.image = image

        textField.anchor(top: contentView.topAnchor, left: textFieldIcon.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        textFieldIcon.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: textField.leftAnchor)

        dividerView.backgroundColor = UIColor.dividedView
        dividerView.anchor(left: textFieldIcon.rightAnchor, bottom: contentView.bottomAnchor, right: textField.rightAnchor, paddingRight: 25, height: 0.75)

        errorLabel.anchor(top: dividerView.bottomAnchor, left: textFieldIcon.rightAnchor, right: textField.rightAnchor)

        textFieldIcon.setDimensions(width: 25, height: 25)
    }

    func setErrorState(with inlineMessage: String, color: UIColor) {
        errorLabel.text = inlineMessage
        errorLabel.textColor = color
        dividerView.backgroundColor = color
    }

    func setConfirmationState(with confirmationMessage: String, color: UIColor) {
        errorLabel.text = confirmationMessage
        errorLabel.textColor = color
        dividerView.backgroundColor = color
    }

    func configurePasswordFieldConstraint() {
        titleLabel.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
        contentView.anchor(top: titleLabel.bottomAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
    }

    func configureInputField(on platform: CustomFields) {
        switch platform {
        case .email:
            setupCommonInputView(withImage: Icons.mail, withTitleLabel: Texts.Titles.email, withPlaceholder: Texts.Placeholders.email)
        case .password:
            setupPasswordInputView(withImage: Icons.password, withTitleLabel: Texts.Titles.password, withPlaceholder: Texts.Titles.password)
        case .nickname:
            setupCommonInputView(withImage: Icons.person, withTitleLabel: Texts.Titles.name, withPlaceholder: Texts.Placeholders.nickname)
        case .name:
            setupCommonInputView(withImage: Icons.person, withTitleLabel: Texts.Titles.name, withPlaceholder: Texts.Placeholders.namePlaceholder)
        case .surname:
            setupCommonInputView(withImage: Icons.person, withTitleLabel: Texts.Titles.surname, withPlaceholder: Texts.Placeholders.surnamePlaceholder)
        case .repeatPassword:
            setupPasswordInputView(withImage: Icons.password, withTitleLabel: Texts.Titles.repeatPassword, withPlaceholder: Texts.Placeholders.repeatPassword)
        case .captcha:
            setupCommonInputView(withImage: Icons.captcha, withTitleLabel: Texts.Titles.captcha, withPlaceholder: Texts.Placeholders.captcha)
        }
    }
}


//
