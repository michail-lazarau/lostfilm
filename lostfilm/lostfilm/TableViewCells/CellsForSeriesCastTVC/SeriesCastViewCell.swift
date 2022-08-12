import SDWebImage
import UIKit

class SeriesCastViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameRuLabel: UILabel!
    @IBOutlet weak var nameEnLabel: UILabel!
    
    var item: LFPersonModel? {
        didSet {
            guard let item = item else {
                return
            }
            photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            photoImageView.sd_setImage(with: item.photoURL)
            nameEnLabel.text = item.nameEn
            nameRuLabel.text = item.nameRu
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
        photoImageView.sd_cancelCurrentImageLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
