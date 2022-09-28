//
//  Utilities.swift
//  lostfilm
//
//  Created by u.yanouski on 20/09/2022.
//

import Foundation

class Utilities {
    func createInputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        let imageView = UIImageView()

        imageView.image = image
        view.addSubview(imageView)
        imageView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor)
        imageView.setDimensions(width: 22, height: 22)

        view.addSubview(textField)
        textField.anchor(top: view.topAnchor, left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8)
        return view
    }

    func createTextField(withPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = .white
        return textField
    }

    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart,
                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                     NSAttributedString.Key.foregroundColor: UIColor.white])

        attributedTitle.append(NSMutableAttributedString(string: secondPart,
                                                         attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                                                                      NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}
