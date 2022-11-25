import UIKit
import SDWebImage

class EpisodeTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var paragraphView: ParagraphView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var paragraphViewBottom: NSLayoutConstraint!
    var item: VMepisodeItem? {
        didSet {
            paragraphView.label.text = item?.seasonNumber

            if let posterURL = item?.seasonPosterUrl, let details = item?.seasonDetails {
                posterView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                posterView.sd_setImage(with: posterURL)
                detailsLabel.text = details
            } else {
                paragraphViewBottom.isActive = true
                contentStackView.isHidden = true
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
