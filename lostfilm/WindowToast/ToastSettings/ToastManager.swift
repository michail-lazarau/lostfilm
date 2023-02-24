//
//  ToastConfiguration.swift
//  WindowToast
//
//  Created by Mikhail Lazarau on 11.01.23.
//

import Foundation
import UIKit

open class ToastManager {
//    public static let global = ToastManager()

    public let playPosition: ToastPosition
    public var prePosition: ToastPosition?
    public var postPosition: ToastPosition?
    public var autohideDuration: TimeInterval = 3.0
    public var appearingDuration: TimeInterval = 0.35
    public var disappearingDuration: TimeInterval = 0.35
    public var sizeLimits = ToastSizeLimits()

    public init(playPosition: ToastPosition, prePosition: ToastPosition? = nil, postPosition: ToastPosition? = nil) {
        self.playPosition = playPosition
        self.prePosition = prePosition
        self.postPosition = postPosition
    }
}

//    public var edgeInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 12)
//    public var toastColor: [UIUserInterfaceStyle: UIColor]
//    public var radius: CGFloat = 8
