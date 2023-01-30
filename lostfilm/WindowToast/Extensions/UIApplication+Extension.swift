//
//  UIApplication+Extension.swift
//  WindowToast
//
//  Created by Mikhail Lazarau on 27.01.23.
//

import Foundation
import UIKit

extension UIApplication {
    func getWindowsByLevel(_ level: UIWindow.Level) -> [UIWindow] {
        let windows = connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        return windows.filter { $0.windowLevel == level }
    }
}
