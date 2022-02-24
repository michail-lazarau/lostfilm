import UIKit
import SDWebImage

class EpisodeTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var paragraphView: ParagraphView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var contentStackViewBottom: NSLayoutConstraint!
    @IBOutlet weak var contentStackViewTop: NSLayoutConstraint!
    @IBOutlet weak var contentStackViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var contentStackViewLeading: NSLayoutConstraint!
    var item: VMepisodeItem? {
        didSet {
            paragraphView.label.text = item?.seasonNumber
            
            if let posterURL = item?.seasonPosterUrl, let details = item?.seasonDetails {
                posterView.sd_setImage(with: posterURL)
                detailsLabel.text = details
            } else {
                contentStackViewTop.isActive = false
                contentStackViewBottom.isActive = false
                contentStackViewLeading.isActive = false
                contentStackViewTrailing.isActive = false
                contentStackView.isHidden = true
            }
        }
    }
    
    class var reuseIdentifier: String {
//        String(describing: self)
        "EpisodeTableHeaderView"
    }
    
    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
