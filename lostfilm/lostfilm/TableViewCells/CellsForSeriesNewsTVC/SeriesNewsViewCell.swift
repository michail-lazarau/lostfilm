import UIKit
import SDWebImage

class SeriesNewsViewCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var briefTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var item: LFNewsModel? {
        didSet {
            if let item = item {
                photoView.sd_setImage(with: item.photoUrl)
                typeLabel.text = item.type
                titleLabel.text = item.title
                briefTextLabel.text = item.briefText
                dateLabel.text = dateToString(date: item.date, dateFormat: "dd MMMM yyyy г.")
            }
        }
    }
    
    class var reuseIdentifier: String {
//        String(describing: self)
        "SeriesNewsViewCell"
    }
    
    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
