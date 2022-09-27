import SDWebImage
import UIKit

class SeriesCastViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameRuLabel: UILabel!
    @IBOutlet weak var nameEnLabel: UILabel!
    @IBOutlet weak var roleRuLabel: UILabel!
    @IBOutlet weak var roleEnLabel: UILabel!
    @IBOutlet weak var roleContainerView: UIView!

    var item: LFPersonModel? {
        didSet {
            guard let item = item else {
                return
            }
            photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            photoImageView.sd_setImage(with: item.photoURL)
            nameEnLabel.text = item.nameEn
            nameRuLabel.text = item.nameRu
            if let roleRu = item.roleRu, let roleEn = item.roleEn {
                roleRuLabel.text = roleRu
                roleEnLabel.text = roleEn
            } else {
                roleContainerView.isHidden = true
            }
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
