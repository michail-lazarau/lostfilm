import UIKit
import SDWebImage

class SeriesPosterViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingViewContainer: UIView!
    let height: CGFloat = 175
    var item: VMseriesItem? {
        didSet {
            guard let item = item as? VMseriesPosterItem else {
                return
            }
            posterImageView.sd_setImage(with: item.posterUrl)
            ratingLabel.text = String(format: "%.1f", item.rating)
        }
    }
    
    class var reuseIdentifier: String {
//        String(describing: self)
        "SeriesPosterViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
    }
}
