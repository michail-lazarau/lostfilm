import UIKit

// https://fluffy.es/handling-button-tap-inside-uitableviewcell-without-using-tag/

class BaseFilterViewCell: UITableViewCell {
    var switcherAction: (()->())?
    var switcher: UISwitch!
    
    static func cellIdentifier() -> String {
        "BaseFilterViewCell"
    }
    
//    MARK: ask about usage of << override var reuseIdentifier: String {"BaseFilterViewCell"} >>
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        switcher = UISwitch()
        accessoryView = switcher
        switcher.addTarget(self, action: #selector(switcherTapped(_:)), for: .valueChanged)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func switcherTapped(_ sender: UISwitch) {
        switcherAction?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
