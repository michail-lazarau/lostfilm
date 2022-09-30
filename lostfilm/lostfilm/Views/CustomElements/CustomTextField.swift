//
//  CustomTextField.swift
//  lostfilm
//
//  Created by u.yanouski on 28/09/2022.
//

import UIKit

// MARK: File Private Variables

fileprivate let defaultFontSize: CGFloat = 10

final class CustomTextField: UIView {

    // MARK: Variabels

    var buttonON = false

    // MARK: Subviews
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .darkGray
        textField.font = .systemFont(ofSize: defaultFontSize, weight: .medium)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: defaultFontSize, weight: .semibold)
        titleLabel.textColor = .red
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    var textFieldIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let passwordButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_play")
        button.backgroundColor = .gray
        button.setImage(image, for: .normal)
        button.alpha = 1
        button.addTarget(self, action: #selector(passwordButtonPressed), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.contentMode = .scaleToFill
        return contentView
    }()

    // MARK: Inits

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(textFieldIcon)
        setupContentView()
        setupStackView(withViews: [UIView(), titleLabel, contentView])
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        textField.isSecureTextEntry = false
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
        textField.alpha = 0.5
    }

    @objc func passwordButtonPressed() {
        if buttonON {
            passwordButton.setImage(UIImage(named: "icon_filter_active"), for: .normal)
            hidePassword()
        } else {
            showPassword()
            passwordButton.setImage(UIImage(named: "icon_play"), for: .normal)
        }
        buttonON = !buttonON
    }
}

    // MARK: Extension

extension CustomTextField {

    func setupStackView(withViews views: [UIView]) {
        for view in views {
            stackView.addArrangedSubview(view)
        }
    }

    func setupContentView() {
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

    enum CustomFields {
        case name
        case surname
        case email
        case password
    }

    func configureInputField(on platform: CustomFields) {
        switch platform {
        case .name:
            setupCommonInputView(withImage: UIImage(named: "close")!, withTitleLabel: Texts.name.uppercased())
        case .surname:
            setupCommonInputView(withImage: UIImage(named: "icon_filter_active")!, withTitleLabel: Texts.surname.uppercased())
        case .email:
            setupCommonInputView(withImage: UIImage(named: "icon_filter")!, withTitleLabel: Texts.email.uppercased())
        case .password:
            setupPasswordInputView()
        }
    }
}
