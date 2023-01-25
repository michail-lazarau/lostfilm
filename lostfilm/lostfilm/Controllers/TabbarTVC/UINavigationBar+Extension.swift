import Foundation
import UIKit

extension UINavigationBar {

    var largeTitleHeight: CGFloat {

        let maxSize = self.subviews
            .filter { $0.frame.origin.y > 0 && $0.subviews.contains(where: { $0 is UILabel }) }
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxSize?.height ?? 0
        }
}

//    func getCompactHeight() -> CGFloat {
//
//        /// Loop through the navigation bar's subviews.
//        for subview in subviews {
//
//            /// Check if the subview is pinned to the top (compact bar) and contains a title label
//            if subview.frame.origin.y == 0 && subview.subviews.contains(where: { $0 is UILabel }) {
//                return subview.bounds.height
//            }
//        }
//
//        return 0
//    }

//        let subviewsBelowZeroOrigin = self.subviews.filter { $0.frame.origin.y > 0 }
//
//        let maxYOrigin = subviewsBelowZeroOrigin.map { $0.frame.origin.y } .max { $0 < $1 }
//
//        let titleView = subviewsBelowZeroOrigin.filter { $0.frame.origin.y == maxYOrigin }.filter { $0.subviews.contains(where: { $0 is UILabel }) }

//            let maxSize = self.subviews
//                .filter { $0.frame.origin.y > 0 }
//                .max { $0.frame.origin.y < $1.frame.origin.y }
//                .map { $0.frame.size }
//            return maxSize?.height ?? 0
