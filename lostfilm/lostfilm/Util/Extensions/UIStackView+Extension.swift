//
//  UIStackView+Extension.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-22.
//

import Foundation

extension UIStackView {
    func setupSubViews(withViews views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
