import UIKit

class SeriesViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // reuseIdentifier: String(describing: type(of: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "System", size: 12.0)
        title.textColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
        title.numberOfLines = 2
        return title
    }()
    
    private let subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont(name: "System", size: 10.0)
        subtitle.textColor = UIColor(red: 157/255, green: 157/255, blue: 160/255, alpha: 1.0)
        subtitle.numberOfLines = 2
        return subtitle
    }()
    
    private let details: UILabel = {
        let details = UILabel()
        details.font = UIFont(name: "System", size: 11.0)
        details.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
        details.numberOfLines = 0
        return details
    }()
    
    private var cellStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
//        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    func configureWith(dataModel: LFSeriesModel) {
        imageView?.image = try? UIImage(data: Data(contentsOf: dataModel.photoUrl))
        title.text = dataModel.nameRu
        subtitle.text = dataModel.nameEn
        details.text = dataModel.details
    }
    
    private func setupCellStackView() {
        imageView?.contentMode = .scaleAspectFill
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        if let imageView = self.imageView {
            cellStackView.addArrangedSubview(imageView)
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3.0/5.0).isActive = true
        }
        
        setupLabelStackView()
        cellStackView.addArrangedSubview(labelStackView)
        addSubview(labelStackView)
        addSubview(cellStackView)
        
        if let superview = superview {
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            cellStackView.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            cellStackView.topAnchor.constraint(equalTo: superview.topAnchor, constant: 12),
            cellStackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 12)
        ])
        }
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
