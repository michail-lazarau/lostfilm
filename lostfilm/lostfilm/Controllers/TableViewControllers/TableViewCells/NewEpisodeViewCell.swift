import UIKit

class NewEpisodeViewCell: UITableViewCell, CellConfigurable {
    
    static func cellIdentifier() -> String {
        "NewEpisodeViewCell"
    }
    
    func configureWith(dataModel: LFEpisodeModel) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 8
//        paragraphStyle.headIndent = 8
//        paragraphStyle.tailIndent = -8
        
        newEpisodeImageView.sd_setImage(with: dataModel.series.photoUrl)
//        episodeNumLabel.text = "\(dataModel.seasonNumber) сезон \(dataModel.number) серия"
        episodeNumLabel.attributedText = NSAttributedString(string: "\(dataModel.seasonNumber) сезон \(dataModel.number) серия", attributes: [.paragraphStyle : paragraphStyle])
        tvSeriesTitleRuLabel.text = dataModel.series.nameRu
        tvSeriesTitleEnLabel.text = dataModel.series.nameEn
        episodeTitleRuLabel.text = dataModel.titleRu
        episodeTitleEnLabel.text = dataModel.titleEn
        
        if (dataModel.dateRu != nil) {
            let releaseDateRu = dateToString(date: dataModel.dateRu, dateFormat: "dd.MM.yyyy")
            releaseDateRuLabel.text = "Дата выхода Ru: \(releaseDateRu)"
            // insert logics of daysBeforeReleaseLabel
        } else {
            releaseDateRuLabel.isHidden = true
            daysBeforeReleaseLabel.isHidden = true
        }
        
        if (dataModel.dateEn != nil) {
            let releaseDateEn = dateToString(date: dataModel.dateEn, dateFormat: "dd.MM.yyyy")
            releaseDateEnLabel.text = "Дата выхода En: \(releaseDateEn)"
        } else {
            releaseDateEnLabel.isHidden = true
        }
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private let newEpisodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let episodeNumLabel: UILabel = {
        let episodeNum = UILabel()
        episodeNum.font = UIFont.boldSystemFont(ofSize: 12.0)
        episodeNum.textColor = .white
        episodeNum.backgroundColor = UIColor(red: 31 / 255, green: 31 / 255, blue: 31 / 255, alpha: 0.8)
        episodeNum.numberOfLines = 1
        episodeNum.lineBreakMode = .byTruncatingTail
        episodeNum.translatesAutoresizingMaskIntoConstraints = false
        return episodeNum
    }()
    
    private let tvSeriesTitleRuLabel: UILabel = {
        let tvSeriesTitleRu = UILabel()
        tvSeriesTitleRu.font = UIFont.systemFont(ofSize: 10.0)
        tvSeriesTitleRu.textColor = UIColor(red: 31 / 255, green: 31 / 255, blue: 31 / 255, alpha: 1.0)
        tvSeriesTitleRu.numberOfLines = 2
        tvSeriesTitleRu.lineBreakMode = .byTruncatingTail
        return tvSeriesTitleRu
    }()
    
    private let tvSeriesTitleEnLabel: UILabel = {
        let tvSeriesTitleEn = UILabel()
        tvSeriesTitleEn.font = UIFont.systemFont(ofSize: 10.0)
        tvSeriesTitleEn.textColor = UIColor(red: 157 / 255, green: 157 / 255, blue: 160 / 255, alpha: 1.0)
        tvSeriesTitleEn.numberOfLines = 2
        tvSeriesTitleEn.lineBreakMode = .byTruncatingTail
        return tvSeriesTitleEn
    }()

    private let episodeTitleRuLabel: UILabel = {
        let episodeTitleRu = UILabel()
        episodeTitleRu.font = UIFont.systemFont(ofSize: 10.0)
        episodeTitleRu.textColor = UIColor(red: 31 / 255, green: 31 / 255, blue: 31 / 255, alpha: 1.0)
        episodeTitleRu.numberOfLines = 2
        episodeTitleRu.lineBreakMode = .byTruncatingTail
        return episodeTitleRu
    }()
    
    private let episodeTitleEnLabel: UILabel = {
        let episodeTitleEn = UILabel()
        episodeTitleEn.font = UIFont.systemFont(ofSize: 10.0)
        episodeTitleEn.textColor = UIColor(red: 157 / 255, green: 157 / 255, blue: 160 / 255, alpha: 1.0)
        episodeTitleEn.numberOfLines = 2
        episodeTitleEn.lineBreakMode = .byTruncatingTail
        return episodeTitleEn
    }()
    
    private let releaseDateRuLabel: UILabel = {
        let releaseDateRu = UILabel()
        releaseDateRu.font = UIFont.systemFont(ofSize: 10.0)
        releaseDateRu.textColor = UIColor(red: 31 / 255, green: 31 / 255, blue: 31 / 255, alpha: 1.0)
        releaseDateRu.numberOfLines = 2
        releaseDateRu.lineBreakMode = .byTruncatingTail
        return releaseDateRu
    }()
    
    private let releaseDateEnLabel: UILabel = {
        let releaseDateEn = UILabel()
        releaseDateEn.font = UIFont.systemFont(ofSize: 10.0)
        releaseDateEn.textColor = UIColor(red: 157 / 255, green: 157 / 255, blue: 160 / 255, alpha: 1.0)
        releaseDateEn.numberOfLines = 2
        releaseDateEn.lineBreakMode = .byTruncatingTail
        return releaseDateEn
    }()
    
    private let daysBeforeReleaseLabel: UILabel = {
        let daysBeforeRelease = UILabel()
        daysBeforeRelease.font = UIFont.systemFont(ofSize: 17.0)
        daysBeforeRelease.textColor = .black
        daysBeforeRelease.numberOfLines = 1
        daysBeforeRelease.lineBreakMode = .byTruncatingTail
        return daysBeforeRelease
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
//        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupCellStackView() {
        setupLabelStackView()
        cellStackView.addArrangedSubview(newEpisodeImageView)
        cellStackView.addArrangedSubview(labelStackView)
        
        contentView.addSubview(cellStackView)
        contentView.addSubview(episodeNumLabel)
        
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
//            episodeNumLabel.heightAnchor.constraint(equalToConstant: episodeNumLabel.intrinsicContentSize.height + 16),
            episodeNumLabel.heightAnchor.constraint(equalToConstant: 30),
            episodeNumLabel.leadingAnchor.constraint(equalTo: newEpisodeImageView.leadingAnchor),
            episodeNumLabel.trailingAnchor.constraint(equalTo: newEpisodeImageView.trailingAnchor),
            episodeNumLabel.bottomAnchor.constraint(equalTo: newEpisodeImageView.bottomAnchor)
        ])
        
        newEpisodeImageView.heightAnchor.constraint(equalTo: newEpisodeImageView.widthAnchor, multiplier: 3.0 / 5.0).isActive = true
    }
    
    private func setupLabelStackView() {
        let tvSeriesTitleStack = UIStackView(arrangedSubviews: [tvSeriesTitleRuLabel, tvSeriesTitleEnLabel])
        tvSeriesTitleStack.axis = .vertical
        let episodeTitleStack = UIStackView(arrangedSubviews: [episodeTitleRuLabel, episodeTitleEnLabel])
        episodeTitleStack.axis = .vertical
        let releaseDateStack = UIStackView(arrangedSubviews: [releaseDateRuLabel, releaseDateEnLabel])
        releaseDateStack.axis = .vertical
        
        labelStackView.addArrangedSubview(tvSeriesTitleStack)
        labelStackView.addArrangedSubview(episodeTitleStack)
        labelStackView.addArrangedSubview(releaseDateStack)
        labelStackView.addArrangedSubview(daysBeforeReleaseLabel)
    }
    
//    setupLabelWith(font: .systemFont(ofSize: 10.0), textColor: UIColor(red: 31 / 255, green: 31 / 255, blue: 31 / 255, alpha: 1.0), numberOfLines: 2)
//    private func setupLabelWith(font: UIFont, textColor: UIColor, numberOfLines: Int) -> UILabel {
//        let label = UILabel()
//        label.font = font
//        label.textColor = textColor
//        label.numberOfLines = numberOfLines
//        label.lineBreakMode = .byTruncatingTail
//        return label
//    }
}
