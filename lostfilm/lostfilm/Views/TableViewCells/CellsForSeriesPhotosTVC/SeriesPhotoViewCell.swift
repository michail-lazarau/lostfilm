import SDWebImage
import UIKit

class SeriesPhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    var item: LFPhotoModel? {
        didSet {
            guard let item = item else {
                return
            }
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
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
        imageView.sd_cancelCurrentImageLoad()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        viewTransitionSetup()
        // Initialization code
    }

    private func viewTransitionSetup() {
        imageView.sd_imageTransition = SDWebImageTransition.fade
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }

}
