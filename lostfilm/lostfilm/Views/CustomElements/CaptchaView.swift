//
//  captchaButton.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-09.
//

import Foundation

 final class CaptchaView: UIView {

    private let contentView = UIView()

    lazy var checkmarkButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "checkmark.square")
        button.layer.cornerRadius  = 5
        button.setImage(image, for: .normal)
        button.tintColor  = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "figure.walk")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubview(contentView)
        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentView() {
        contentView.addSubview(imageView)
        contentView.addSubview(checkmarkButton)
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)

        checkmarkButton.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: imageView.leftAnchor, width: 25, height: 25)
        imageView.anchor(top: contentView.topAnchor, left: checkmarkButton.rightAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
    }
}
