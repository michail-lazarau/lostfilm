import UIKit

@IBDesignable
class ParagraphView: UIView {
    @IBOutlet weak var label: UILabel!
    
    //coder is a must
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        let bundle = Bundle.init(for: ParagraphView.self)
        if let viewToAdd = bundle.loadNibNamed("ParagraphView", owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        // Extension: loadViewFromNib
//        if let view = loadViewFromNib(nibName: "ParagraphView") {
//            addSubview(view)
//            view.frame = self.bounds
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        }
    }

}
