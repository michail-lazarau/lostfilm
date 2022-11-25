import UIKit

class EpisodeViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: OrderNumberLabel!
    @IBOutlet weak var titleRuLabel: UILabel!
    @IBOutlet weak var titleEnLabel: UILabel!
    @IBOutlet weak var dateRuLabel: UILabel!
    @IBOutlet weak var dateEnLabel: UILabel!
    var item: LFEpisodeModel? {
        didSet {
            if traitCollection.userInterfaceIdiom == .pad {
                let padDateFontRu = UIFont.monospacedDigitSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize, weight: .regular)
                let padDateFontEn = UIFont.monospacedDigitSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize, weight: .regular)
                numberLabel.font = padDateFontRu
                dateRuLabel.font = padDateFontRu
                dateEnLabel.font = padDateFontEn
            }

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
