import UIKit

class EpisodeViewCell: UITableViewCell {
    var item: LFEpisodeModel? {
        didSet {
            
        }
    }
    
    class var reuseIdentifier: String {
//        String(describing: self)
        "EpisodeViewCell"
    }
    
    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
