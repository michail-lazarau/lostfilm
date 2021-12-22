import UIKit

class NewsViewCell: UITableViewCell, CellConfigurable {
    
    static func cellIdentifier() -> String {
        "NewsViewCell"
    }
    
    func configureWith(dataModel: LFNewsModel) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 6
        
        newsImageView.sd_setImage(with: dataModel.photoUrl)
        newsTypeLabel.attributedText = NSAttributedString(string: dataModel.type, attributes: [.paragraphStyle : paragraphStyle])
        titleLabel.text = dataModel.title
        briefTextLabel.text = dataModel.briefText
        dateLabel.text = dateToString(date: dataModel.date, locale: Locale(identifier: "ru_RU"), dateFormat: "dd MMMM yyyy г.")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellStackView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true //MARK: because the image expands beyond its view due to non-fitting aspect ratio
        return imageView
    }()
    
    private let newsTypeLabel: UILabel = {
        let newsType = UILabel()
        newsType.font = UIFont.boldSystemFont(ofSize: 12.0)
        newsType.textColor = .white
        newsType.numberOfLines = 1
        newsType.backgroundColor = UIColor(red: 31 / 255, green: 31 / 255, blue: 31 / 255, alpha: 0.8)
        newsType.translatesAutoresizingMaskIntoConstraints = false
        return newsType
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 17.0)
        title.textColor = .black
        title.numberOfLines = 2
        title.setContentHuggingPriority(UILayoutPriority.init(252), for: .vertical)
        title.lineBreakMode = .byTruncatingTail
        return title
    }()
    
    private let briefTextLabel: UILabel = {
        let briefText = UILabel()
        briefText.font = UIFont.systemFont(ofSize: 11.0)
        briefText.textColor = UIColor(red: 157 / 255, green: 157 / 255, blue: 160 / 255, alpha: 1.0)
        briefText.numberOfLines = 0
        briefText.setContentHuggingPriority(UILayoutPriority.init(251), for: .vertical)
        briefText.lineBreakMode = .byTruncatingTail
        return briefText
    }()
 
    private let dateLabel: UILabel = {
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: 9.0)
        date.textColor = UIColor(red: 157 / 255, green: 157 / 255, blue: 160 / 255, alpha: 1.0)
        date.numberOfLines = 1
        date.setContentHuggingPriority(UILayoutPriority.init(253), for: .vertical)
        return date
    }()
    
    private var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCellStackView() {
        setupLabelStackView()
        cellStackView.addArrangedSubview(newsImageView)
        cellStackView.addArrangedSubview(labelStackView)
        
        contentView.addSubview(cellStackView)
        contentView.addSubview(newsTypeLabel)
        
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            newsTypeLabel.heightAnchor.constraint(equalToConstant: 25),
            newsTypeLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            newsTypeLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),
            newsTypeLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor)
        ])
        
        newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor, multiplier: 9.0 / 16.0).isActive = true
    }
    
    private func setupLabelStackView() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(briefTextLabel)
        labelStackView.addArrangedSubview(dateLabel)
    }
}

//        UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
//        override var intrinsicContentSize: CGSize {
//            var intrinsicContentSize = super.intrinsicContentSize
//            intrinsicContentSize.width += inset.left + inset.right
//            intrinsicContentSize.height += inset.top + inset.bottom
//            return intrinsicContentSize
//        }
