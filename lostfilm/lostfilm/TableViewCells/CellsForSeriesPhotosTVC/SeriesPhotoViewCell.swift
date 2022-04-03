import SDWebImage
import UIKit

class SeriesPhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var highQualityImageView: UIImageView? {
        if let highQualityImageUrl = item?.highQualityImageUrl {
            let highQualityImageView = imageView
            highQualityImageView?.sd_setImage(with: highQualityImageUrl)
            return highQualityImageView
        } else {
            return nil
        }
    }
    
    var item: LFPhotoModel? {
        didSet {
            guard let item = item else {
                return
            }
            imageView.sd_setImage(with: item.url)
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
        item = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
