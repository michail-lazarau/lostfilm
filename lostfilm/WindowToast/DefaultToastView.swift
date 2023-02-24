//
//  DefaultToastView.swift
//  WindowToast
//
//  Created by Mikhail Lazarau on 23.01.23.
//

import UIKit

public class DefaultToastView: UIView {
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor.white : UIColor.black
        }
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        return imageView
    }()

//    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//    }

    public var messageLabel: UILabel = {
        let message = UILabel()
        let staticFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        message.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: staticFont)
        message.textColor = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor.white : UIColor(red: 32 / 255, green: 32 / 255, blue: 32 / 255, alpha: 1.0)
        }
        message.numberOfLines = 2
        return message
    }()

    public var descriptionLabel: UILabel? = {
        let description = UILabel()
        let staticFont = UIFont.systemFont(ofSize: 10, weight: .light)
        description.font = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: staticFont)

        description.textColor = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor.lightGray : UIColor(red: 157 / 255, green: 157 / 255, blue: 160 / 255, alpha: 1.0)
        }
        description.numberOfLines = 0
        return description
    }()

    public let generalContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    public let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 6
        return stackView
    }()

    public convenience init(backgroundColor: UIColor, message: UILabel, description: UILabel?, image: UIImage?, edgeInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)) {
        self.init(image: image, edgeInsets: edgeInsets)
        messageLabel = message
        descriptionLabel = description
        self.backgroundColor = backgroundColor
    }

    public convenience init(backgroundColor: UIColor, message: String, description: String?, image: UIImage?, edgeInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)) {
        self.init(image: image, edgeInsets: edgeInsets)
        messageLabel.text = message
        descriptionLabel?.text = description
        self.backgroundColor = backgroundColor
    }

    public convenience init() {
        let mockText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        let backgroundColor = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 0.96)
                : UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 0.96)
        }
        self.init(backgroundColor: backgroundColor, message: mockText, description: mockText, image: UIImage(systemName: "magnifyingglass"))
    }

    private init(image: UIImage?, edgeInsets: NSDirectionalEdgeInsets) {
        super.init(frame: .zero)
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        generalContainer.directionalLayoutMargins = edgeInsets
        didSetupGeneralContainer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func didSetupGeneralContainer() {
        didSetupLabelStackView()
        generalContainer.addArrangedSubview(imageView)
        generalContainer.addArrangedSubview(labelStackView)
        addSubview(generalContainer)

        NSLayoutConstraint.activate([
            generalContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            generalContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            generalContainer.topAnchor.constraint(equalTo: topAnchor),
            generalContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func didSetupLabelStackView() {
        labelStackView.addArrangedSubview(messageLabel)
        if let descriptionLabel = descriptionLabel {
            labelStackView.addArrangedSubview(descriptionLabel)
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 4
    }
}
