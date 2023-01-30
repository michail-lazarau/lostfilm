//
//  UIViewController+Extension.swift
//  WindowToast
//
//  Created by Mikhail Lazarau on 30.01.23.
//

import Foundation
import UIKit

extension UIViewController {
    func getLastDescendantViewController() -> UIViewController? {
        let ancestorVC: UIViewController?
        switch self {
        case let root as UINavigationController:
            ancestorVC = root.topViewController
        case let root as UITabBarController:
            ancestorVC = root.selectedViewController
        case let root as UISplitViewController:
            if root.traitCollection.horizontalSizeClass == .compact {
                ancestorVC = root.viewControllers.first
            } else {
                ancestorVC = root.isCollapsed ? root.viewControllers.first : root.viewControllers.last
            }
        case let root as UIPageViewController:
            ancestorVC = root.viewControllers?.first
        default:
            if presentedViewController == nil {
                return self
            } else {
                return presentedViewController is UIAlertController ? self : presentedViewController
            }
        }

        // MARK: continue recursion
        return ancestorVC?.getLastDescendantViewController()
    }
}
