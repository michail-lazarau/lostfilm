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

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12.0)
        title.textColor = .white
        title.numberOfLines = 1
        title.lineBreakMode = .byTruncatingTail
        return title
    }()

    private let detailsLabel: UILabel = {
        let details = UILabel()
        details.font = UIFont.systemFont(ofSize: 9.0)
        details.textColor = .white
        details.numberOfLines = 1
        details.lineBreakMode = .byTruncatingTail
        return details
    }()

    private let launchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon_play"), for: .normal)
        button.frame.size = CGSize(width: 45, height: 45)
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
        contentView.addSubview(launchButton)
        
        NSLayoutConstraint.activate([
            videoImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            videoImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            videoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            launchButton.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            launchButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            launchButton.heightAnchor.constraint(equalTo: launchButton.widthAnchor, multiplier: 1.0 / 1.0),
            
            labelStackView.heightAnchor.constraint(equalToConstant: 44),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    @objc private func launchVideoPlayer() {
        if let videoUrl = videoUrl {
            videoViewCellDelegate?.launchVideo(by: videoUrl)
        }
    }
}
