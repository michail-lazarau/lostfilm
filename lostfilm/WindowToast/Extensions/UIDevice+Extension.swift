import Foundation
import UIKit

// https://stackoverflow.com/questions/52402477/ios-detect-if-the-device-is-iphone-x-family-frameless
// https://medium.com/evangelist-apps/getting-ios-device-orientation-right-after-the-app-launch-in-swift-21b08d775de6

extension UIDevice {
    /// Returns `true` if the device has a notch
    var hasNotch: Bool {
        guard #available(iOS 13.0, *), let window = UIApplication.shared.connectedScenes.flatMap({ ($0 as? UIWindowScene)?.windows ?? [] }).first(where: { $0.isKeyWindow }), let orientation = window.windowScene?.interfaceOrientation else { return false }
        if orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}

//        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return false }
//        if UIDevice.current.orientation.isPortrait {
//            return window.safeAreaInsets.top >= 44
//        } else {
//            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
//        }
