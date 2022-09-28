import UIKit

class EpisodeViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleRuLabel: UILabel!
    @IBOutlet weak var titleEnLabel: UILabel!
    @IBOutlet weak var dateRuLabel: UILabel!
    @IBOutlet weak var dateEnLabel: UILabel!
    var item: LFEpisodeModel? {
        didSet {
            if let number = item?.number {
                numberLabel.text = "\(number)"
            } else {
                numberLabel.isHidden = true
            }

            if let titleRu = item?.titleRu {
                titleRuLabel.text = titleRu
            } else {
                titleRuLabel.isHidden = true
            }

            if let titleEn = item?.titleEn {
                titleEnLabel.text = titleEn
            } else {
                titleEnLabel.isHidden = true
            }

            if let dateRu = item?.dateRu {
                dateRuLabel.text = dateToString(date: dateRu, dateFormat: "dd.MM.yyyy")
            } else {
                dateRuLabel.isHidden = true
            }

            if let dateEn = item?.dateEn {
                dateEnLabel.text = dateToString(date: dateEn, dateFormat: "dd.MM.yyyy")
            } else {
                dateEnLabel.isHidden = true
            }
        }
    }

    class var reuseIdentifier: String {
        String(describing: self)
    }

    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
