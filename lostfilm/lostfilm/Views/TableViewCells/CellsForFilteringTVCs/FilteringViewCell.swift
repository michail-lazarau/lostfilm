import UIKit

class FilteringViewCell: UITableViewCell, CellConfigurable {

    var item: LFSeriesFilterBaseModel? {
        didSet {
            if let item = item {
                configureWith(dataModel: item)
            }
        }
    }

    func configureWith(dataModel: LFSeriesFilterBaseModel) {
        textLabel?.text = dataModel.name
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
