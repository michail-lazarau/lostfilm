//
//  UIStackView+Extension.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-22.
//

import Foundation

extension UIStackView {
    func setupSubViews(withViews views: [UIView]) { // cделать экстенш к функции стэк вью
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
