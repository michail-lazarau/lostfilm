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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        return imageView
    }()

    public let messageLabel: UILabel = {
        let message = UILabel()
        let staticFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        message.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: staticFont)
        message.textColor = UIColor(red: 32 / 255, green: 32 / 255, blue: 32 / 255, alpha: 1.0)
        message.numberOfLines = 2
        return message
    }()

    public let descriptionLabel: UILabel = {
        let description = UILabel()
        let staticFont = UIFont.systemFont(ofSize: 10, weight: .light)
        description.font = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: staticFont)
        description.textColor = UIColor(red: 157 / 255, green: 157 / 255, blue: 160 / 255, alpha: 1.0)
        description.numberOfLines = 0
        return description
    }()

    public let backgroundColorSet: [UIUserInterfaceStyle: UIColor] = {
        [.dark: UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 0.96),
         .light: UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 0.96),
         .unspecified: UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 0.96)]
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

//    public let blurredView: UIVisualEffectView = {
//        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
//        blurredView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurredView.alpha = 0.97
//        return blurredView
//    }()

    public init(image: UIImage? = nil, edgeInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)) {
        super.init(frame: .zero)
        imageView.image = image
        generalContainer.directionalLayoutMargins = edgeInsets
//        backgroundColor = nil
        backgroundColor = backgroundColorSet[traitCollection.userInterfaceStyle]
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

//        self.insertSubview(blurredView, at: 0)

        NSLayoutConstraint.activate([
            generalContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            generalContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            generalContainer.topAnchor.constraint(equalTo: topAnchor),
            generalContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

//        generalContainer.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
//        generalContainer.frame = self.bounds
    }

    private func didSetupLabelStackView() {
        labelStackView.addArrangedSubview(messageLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 4

//        blurredView.frame = self.bounds
//        blurredView.layer.cornerRadius = layer.cornerRadius
    }
}
