//
//  ToastConfiguration.swift
//  WindowToast
//
//  Created by Mikhail Lazarau on 11.01.23.
//

import Foundation

open class ToastManager {
//    public static let global = ToastManager()

    let playPosition: ToastPosition
    var prePosition: ToastPosition?
    var postPosition: ToastPosition?
//    let timerFiringInterval: TimeInterval

    public init(playPosition: ToastPosition, prePosition: ToastPosition? = nil, postPosition: ToastPosition? = nil) {
        self.playPosition = playPosition
        self.prePosition = prePosition
        self.postPosition = postPosition
    }
}
