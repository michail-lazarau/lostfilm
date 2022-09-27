import UIKit

class GlobalSearchHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var paragraphView: ParagraphView!
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
