import SDWebImage
import UIKit

class SeriesViewCell: UITableViewCell, CellConfigurable {
    
//    typealias DataModel = LFSeriesModel // not sure if it makes any sence
    
    func configureWith(dataModel: LFSeriesModel) {
        serialView.sd_setImage(with: dataModel.photoUrl)
        title.text = dataModel.nameRu
        subtitle.text = dataModel.nameEn
        details.text = dataModel.details
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.clipsToBounds = true
        setupCellStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // FIXME: class or static? I want to call this property out of any cellClass and receive the respective self. I don't want to override the property later. I assume it must be static.
    class var cellIdentifier: String {
        String(describing: type(of: self))
    }

    private let serialView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 12.0)
        title.textColor = UIColor(red: 32 / 255, green: 32 / 255, blue: 32 / 255, alpha: 1.0)
        title.numberOfLines = 2
        return title
    }()

    private let subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont.systemFont(ofSize: 10.0)
        subtitle.textColor = UIColor(red: 157 / 255, green: 157 / 255, blue: 160 / 255, alpha: 1.0)
        subtitle.numberOfLines = 2
        return subtitle
    }()

    private let details: UILabel = {
        let details = UILabel()
        details.font = UIFont.systemFont(ofSize: 11.0)
        details.textColor = UIColor(red: 102 / 255, green: 102 / 255, blue: 102 / 255, alpha: 1.0)
        details.numberOfLines = 0
        details.lineBreakMode = .byTruncatingTail
//        details.sizeToFit()
//        details.preferredMaxLayoutWidth
//        details.translatesAutoresizingMaskIntoConstraints = false
        return details
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
//                stackView.alignment = .top
//        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private func setupCellStackView() {
        setupLabelStackView()
        cellStackView.addArrangedSubview(serialView)
        cellStackView.addArrangedSubview(labelStackView)
        contentView.addSubview(cellStackView)
//        cellStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
        serialView.heightAnchor.constraint(equalTo: serialView.widthAnchor, multiplier: 3.0 / 5.0).isActive = true
    }

    private func setupLabelStackView() {
        labelStackView.addArrangedSubview(title)
        labelStackView.addArrangedSubview(subtitle)
        labelStackView.addArrangedSubview(details)
        labelStackView.setCustomSpacing(12.0, after: subtitle)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// https://stackoverflow.com/questions/56372172/how-to-create-custom-uitableviewcell-with-dynamic-number-of-labels
