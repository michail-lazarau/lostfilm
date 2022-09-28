import SDWebImage
import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    // MARK: - SubViews
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
}

// MARK: - Public

extension CarouselCollectionViewCell {
    public func configure(by url: URL) {
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_setImage(with: url)
    }
}
