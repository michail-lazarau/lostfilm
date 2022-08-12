import UIKit
import SDWebImage

class SeriesPosterViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingViewContainer: UIView!
    var item: VMseriesItem? {
        didSet {
            if let item = item as? VMseriesPosterItem {
                posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                posterImageView.sd_setImage(with: item.posterUrl)
                ratingLabel.text = String(format: "%.1f", item.rating)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.sd_cancelCurrentImageLoad()
    }
}
