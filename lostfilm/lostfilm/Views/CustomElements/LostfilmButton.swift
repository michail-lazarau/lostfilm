//
//  LostfilmButton.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-10-20.
//

import UIKit

class LostfilmButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    convenience init (title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.alpha = self.isHighlighted ? 0.5 : 1.0
            }
        }
    }

    func setupButton() {
        setBackgroundColor(UIColor.button ?? .blue, for: .normal)
        layer.cornerRadius  = 10
        layer.masksToBounds = true
        heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
}
