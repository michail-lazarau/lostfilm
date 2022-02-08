import UIKit
import SDWebImage

class SeriesPosterViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingViewContainer: UIView!
    var item: VMseriesItem? {
        didSet {
            if let item = item as? VMseriesPosterItem {
                posterImageView.sd_setImage(with: item.posterUrl)
                ratingLabel.text = String(format: "%.1f", item.rating)
            }
        }
    }
    
    class var reuseIdentifier: String {
//        String(describing: self)
        "SeriesPosterViewCell"
    }
    
    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        translatesAutoresizingMaskIntoConstraints = false // MARK: never ever set false
    }
}
