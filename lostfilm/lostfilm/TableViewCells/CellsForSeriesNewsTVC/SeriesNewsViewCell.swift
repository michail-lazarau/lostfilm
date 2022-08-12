import SDWebImage
import UIKit

class SeriesNewsViewCell: UITableViewCell {
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var briefTextLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var item: LFNewsModel? {
        didSet {
            guard let item = item else {
                return
            }
            photoView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            photoView.sd_setImage(with: item.photoUrl)
            typeLabel.text = item.type
            titleLabel.text = item.title
            briefTextLabel.text = item.briefText
            dateLabel.text = dateToString(date: item.date, dateFormat: "dd MMMM yyyy г.")
        }
    }

    class var reuseIdentifier: String {
        String(describing: self)
    }

    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.sd_cancelCurrentImageLoad()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
