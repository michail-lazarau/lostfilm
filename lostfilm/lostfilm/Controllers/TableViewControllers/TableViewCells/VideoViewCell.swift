import UIKit

class VideoViewCell: UITableViewCell, CellConfigurable {
    
    static func cellIdentifier() -> String {
        "VideosViewCell"
    }
    
    func configureWith(dataModel: LFVideoModel) {
        videoImageView.sd_setImage(with: dataModel.previewURL)
        titleLabel.text = dataModel.title
        detailsLabel.text = dataModel.details
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        
        NSLayoutConstraint.activate([
            videoImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            videoImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            videoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            labelStackView.heightAnchor.constraint(equalToConstant: 44),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
