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
        case name
        case surname
        case email
        case password
    }

    // MARK: Subviews

    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .darkGray
        textField.font = .systemFont(ofSize: defaultFontSize, weight: .medium)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
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

    let passwordButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "eye")
        button.backgroundColor = .gray
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
            hidePassword()
        } else {
            showPassword()
            passwordButton.setImage(UIImage(systemName: "eye"), for: .normal)
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

    func setupPasswordInputView() {
        titleLabel.text = Texts.password

        textField.anchor(top: contentView.topAnchor, left: textFieldIcon.rightAnchor, bottom: contentView.bottomAnchor, right: passwordButton.leftAnchor)
        passwordButton.anchor(top: contentView.topAnchor, left: textField.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        passwordButton.setDimensions(width: 25, height: 25)
    }

    func setupCommonInputView(withImage image: UIImage, withTitleLabel title: String ) {
        textField.anchor(top: contentView.topAnchor, left: textFieldIcon.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        textFieldIcon.image = image
        titleLabel.text = title
        textFieldIcon.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: textField.leftAnchor)
        textFieldIcon.setDimensions(width: 25, height: 25)
    }

    func configurePasswordFieldConstraint() {
        titleLabel.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
        contentView.anchor(top: titleLabel.bottomAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor)
    }

    func configureInputField(on platform: CustomFields) {
        switch platform {
        case .name:
            setupCommonInputView(withImage: UIImage(systemName: "person.crop.circle.badge.plus")!, withTitleLabel: Texts.name.uppercased())
        case .surname:
            setupCommonInputView(withImage: UIImage(systemName: "person.crop.rectangle.stack")!, withTitleLabel: Texts.surname.uppercased())
        case .email:
            setupCommonInputView(withImage: UIImage(systemName: "mail")!, withTitleLabel: Texts.email.uppercased())
        case .password:
            setupPasswordInputView()
        }
    }
}
