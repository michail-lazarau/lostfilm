import UIKit

class TextViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    
    var item: LFContentItemModel? {
        didSet {
            if let item = item as? LFAttributedTextContentItemModel {
                textView.attributedText = item.attributedText
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
