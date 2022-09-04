import UIKit

class CarouselViewTableViewCell: UITableViewCell  {
    @IBOutlet weak var carouselView: CarouselView!
    var item: LFContentItemModel? {
        didSet {
            if let item = item as? LFPhotoListContentItemModel {
                carouselView.configureView(with: item)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
}
