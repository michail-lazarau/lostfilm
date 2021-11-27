import UIKit

class SeriesViewCell: UITableViewCell {
    
    required init(dataModel: LFSeriesModel) {
        super.init(style: .default, reuseIdentifier: String(describing: type(of: self)))
        setupCellStackView(dataModel: dataModel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let cellStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupCellStackView(dataModel: LFSeriesModel) {
        imageView?.image = try? UIImage(data: Data(contentsOf: dataModel.photoUrl))
        imageView?.contentMode = .scaleAspectFill
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        if let imageView = self.imageView {
            cellStackView.addArrangedSubview(imageView)
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3.0/5.0).isActive = true
        }
        
        setupLabelStackView(dataModel: dataModel)
        cellStackView.addArrangedSubview(labelStackView)
        addSubview(cellStackView)
    }
    
    private func setupLabelStackView(dataModel: LFSeriesModel) {
        let title = UILabel()
        let subtitle = UILabel()
        let details = UILabel()
        
        title.font = UIFont(name: "System", size: 12.0)
        title.textColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
        title.numberOfLines = 2
        title.text = dataModel.nameRu
        subtitle.font = UIFont(name: "System", size: 10.0)
        subtitle.textColor = UIColor(red: 157/255, green: 157/255, blue: 160/255, alpha: 1.0)
        subtitle.numberOfLines = 2
        subtitle.text = dataModel.nameEn
        details.font = UIFont(name: "System", size: 11.0)
        details.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
        details.numberOfLines = 0
        details.text = dataModel.details
        
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
