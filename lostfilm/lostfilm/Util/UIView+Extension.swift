import Foundation
import UIKit

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

//    private func setup() {
//        // way 1
//        let bundle = Bundle.init(for: EpisodeTableHeaderView.self)
//        if let viewToAdd = bundle.loadNibNamed(EpisodeTableHeaderView.reuseIdentifier, owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
//            addSubview(contentView)
//            contentView.frame = self.bounds
//            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        }
//
//        // way 2
//        if let view = loadViewFromNib(nibName: EpisodeTableHeaderView.reuseIdentifier) {
//            addSubview(view)
//            view.frame = self.bounds
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        }
//    }

