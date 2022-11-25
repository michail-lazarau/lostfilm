import UIKit
import AVKit
import SDWebImage

class VideoViewCell: UITableViewCell, CellConfigurable {

    private(set) var videoUrl: URL?
    weak var videoViewCellDelegate: VideoPlayerDelegate?

    var item: LFVideoModel? {
        didSet {
            if let item = item {
                configureWith(dataModel: item)
            }
        }
    }

    func configureWith(dataModel: LFVideoModel) {
        videoImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        videoImageView.sd_setImage(with: dataModel.previewURL)
        titleLabel.text = dataModel.title
        detailsLabel.text = dataModel.details
        videoUrl = dataModel.videoURL
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        videoImageView.sd_cancelCurrentImageLoad()
    }

    private let videoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.font = traitCollection.userInterfaceIdiom == .pad
        ? UIFont.preferredFont(forTextStyle: .title3)
        : UIFont.systemFont(ofSize: 12.0)
        title.textColor = .white
        title.numberOfLines = 1
        title.lineBreakMode = .byTruncatingTail
        return title
    }()

    private lazy var detailsLabel: UILabel = {
        let details = UILabel()
        details.font = traitCollection.userInterfaceIdiom == .pad
        ? UIFont.preferredFont(forTextStyle: .body)
        : UIFont.systemFont(ofSize: 9.0)
        details.textColor = .white
        details.numberOfLines = 1
        details.lineBreakMode = .byTruncatingTail
        return details
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "icon_play"), for: .normal)
        button.layer.cornerRadius = button.frame.width / 2
        button.addTarget(self, action: #selector(launchVideoPlayer), for: .touchUpInside)
        return button
    }()

    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.backgroundColor = UIColor(red: 31 / 255, green: 31 / 255, blue: 31 / 255, alpha: 0.8)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private func setupCellView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(detailsLabel)

        contentView.addSubview(videoImageView)
        contentView.addSubview(labelStackView)
        contentView.addSubview(playButton)

        let labelStackHeightConstant: CGFloat = traitCollection.userInterfaceIdiom == .pad ? 66 : 44
        let playButtonHeightWidthConstant: CGFloat = traitCollection.userInterfaceIdiom == .pad ? 90 : 45

        NSLayoutConstraint.activate([
            videoImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            videoImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            videoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            playButton.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: playButtonHeightWidthConstant),
            playButton.widthAnchor.constraint(equalToConstant: playButtonHeightWidthConstant),

            labelStackView.heightAnchor.constraint(equalToConstant: labelStackHeightConstant),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc private func launchVideoPlayer() {
        if let videoUrl = videoUrl {
            videoViewCellDelegate?.launchVideo(by: videoUrl)
        }
    }
}
