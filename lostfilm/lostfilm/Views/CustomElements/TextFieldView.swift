//
//  CustomTextField.swift
//  lostfilm
//
//  Created by u.yanouski on 28/09/2022.
//

import UIKit

// MARK: File Private Variables

fileprivate let defaultFontSize: CGFloat = 10

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
    }

    // MARK: Subviews

    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .darkGray
        textField.font = .systemFont(ofSize: defaultFontSize, weight: .medium)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 5
        return textField
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: defaultFontSize, weight: .semibold)
        titleLabel.textColor = .red
        return titleLabel
    }()

    var textFieldIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var passwordButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "eye")
        button.layer.cornerRadius = 5
        button.setImage(image, for: .normal)
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

    // MARK: Inits

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(textFieldIcon)
        setupContentView()
        setupStackView(withViews: [titleLabel, contentView])
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Functions

    func hidePassword() {
        textField.isSecureTextEntry = false
        textField.alpha = 1
    }

    func showPassword() {
        textField.isSecureTextEntry = true
    }

    @objc func passwordButtonPressed() {
        if isButtonSelected {
            passwordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
//            passwordButton.setImage(Icons.openEye, for: .normal)
            hidePassword()
        } else {
            showPassword()
            passwordButton.setImage(UIImage(systemName: "eye"), for: .normal)
//            passwordButton.setImage(Icons.closeEye, for: .normal)
        }
        isButtonSelected = !isButtonSelected
    }
}

    // MARK: Extension

extension TextFieldView {

    func setupStackView(withViews views: [UIView]) {
        for view in views {
            stackView.addArrangedSubview(view)
        }
    }

    func setupContentView() {
        contentView.contentMode = .scaleToFill
        contentView.addSubview(textField)
        contentView.addSubview(passwordButton)
        contentView.addSubview(textFieldIcon)
    }

    func setupPasswordInputView(withImage image: UIImage, withTitleLabel title: String, withPlaceholder placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
        textFieldIcon.image = image

        textField.anchor(top: contentView.topAnchor, left: textFieldIcon.rightAnchor, bottom: contentView.bottomAnchor, right: passwordButton.leftAnchor)
        passwordButton.anchor(top: contentView.topAnchor, left: textField.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        textFieldIcon.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: textField.leftAnchor)

        textFieldIcon.setDimensions(width: 25, height: 25)
        passwordButton.setDimensions(width: 25, height: 25)
    }

    func setupCommonInputView(withImage image: UIImage, withTitleLabel title: String, withPlaceholder placeholder: String) {
        textFieldIcon.image = image
        titleLabel.text = title

        textField.anchor(top: contentView.topAnchor, left: textFieldIcon.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        textFieldIcon.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: textField.leftAnchor)
        textFieldIcon.setDimensions(width: 25, height: 25)
    }

    func configurePasswordFieldConstraint() {
        titleLabel.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
        contentView.anchor(top: titleLabel.bottomAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
    }

    func configureInputField(on platform: CustomFields) {
        switch platform {
        case .email:
            setupCommonInputView(withImage: Icons.mail, withTitleLabel: Texts.Titles.email.uppercased(), withPlaceholder: Texts.Placeholders.email)
        case .password:
            setupPasswordInputView(withImage: Icons.password, withTitleLabel: Texts.Titles.password, withPlaceholder: Texts.Titles.password)
        case .nickname:
            setupCommonInputView(withImage: Icons.person, withTitleLabel: Texts.Titles.name, withPlaceholder: Texts.Placeholders.nickname)
        case .name:
            setupCommonInputView(withImage: Icons.person, withTitleLabel: Texts.Titles.name.uppercased(), withPlaceholder: Texts.Placeholders.surnamePlaceholder)
        case .surname:
            setupCommonInputView(withImage: Icons.person, withTitleLabel: Texts.Titles.surname.uppercased(), withPlaceholder: Texts.Placeholders.surnamePlaceholder)
        case .repeatPassword:
            setupPasswordInputView(withImage: Icons.password, withTitleLabel: Texts.Titles.repeatPassword, withPlaceholder: Texts.Placeholders.repeatPassword)
        }
    }
}
