import SDWebImage
import UIKit

class SeriesPhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var highResolutionImageView: UIImageView? {
        if let highResolutionImageUrl = item?.highResolutionImageUrl {
            let highResolutionImageView = imageView
            highResolutionImageView?.sd_setImage(with: highResolutionImageUrl)
            return highResolutionImageView
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
        viewTransitionSetup()
        // Initialization code
    }
    
    private func viewTransitionSetup() {
        imageView.sd_imageTransition = SDWebImageTransition.fade
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }

}
