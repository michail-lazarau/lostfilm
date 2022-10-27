import UIKit

// https://fluffy.es/handling-button-tap-inside-uitableviewcell-without-using-tag/

class BaseFilterViewCell: UITableViewCell {
    var switcherCallback: (() -> Void)?
    let switcher: UISwitch

    class var reuseIdentifier: String {
        String(describing: self)
    }

// MARK: ask about usage of << override var reuseIdentifier: String {"BaseFilterViewCell"} >>

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        switcher = UISwitch()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = switcher
        switcher.addTarget(self, action: #selector(switcherTapped(_:)), for: .valueChanged)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func switcherTapped(_ sender: UISwitch) {
        switcherCallback?()
    }
}
