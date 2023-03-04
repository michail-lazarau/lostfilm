//
//  UINavigationBar+Extension.swift
//  WindowToast
//
//  Created by Mikhail Lazarau on 25.01.23.
//

import Foundation
import UIKit

extension UINavigationBar {
    public var largeTitleHeight: CGFloat {
        let maxSize = subviews
            .filter { $0.frame.origin.y > 0 && $0.subviews.contains(where: { $0 is UILabel }) }
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxSize?.height ?? 0
    }
}
