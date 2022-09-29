//
//  CustomTextField.swift
//  lostfilm
//
//  Created by u.yanouski on 28/09/2022.
//

import UIKit

fileprivate let defaultFontSize: CGFloat = 10

final class CustomTextField: UIView {

    var buttonON = false

    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .darkGray

        textField.font = .systemFont(ofSize: defaultFontSize, weight: .medium)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
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

    let passwordButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "icon_filter")
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.alpha = 1
        return button
    }()


    init(frame: CGRect = .zero, title: String) {
        super.init(frame: frame)
        setTitle(title: title)
        configure()
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(title: String) {
        titleLabel.text = title.uppercased()
    }

    func configure() {
        addSubview(textField)
        addSubview(titleLabel)
        addSubview(passwordButton)

        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: textField.topAnchor, right: rightAnchor)
        passwordButton.anchor(top: titleLabel.bottomAnchor, left: leftAnchor)
        passwordButton.setDimensions(width: 50, height: 50)
        textField.anchor(top: titleLabel.bottomAnchor, left: passwordButton.rightAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
    }
}
