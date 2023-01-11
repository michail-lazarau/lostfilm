//
//  ToastPosition.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 2.01.23.
//

import Foundation
import UIKit

public struct ToastPosition {
    public init(xAxisPosition: XAxisPosition, yAxisPosition: YAxisPosition) {
        self.xAxisPosition = xAxisPosition
        self.yAxisPosition = yAxisPosition
    }

    let xAxisPosition: XAxisPosition
    let yAxisPosition: YAxisPosition

    func setupPosition(toast: UIButton, superview: UIView) -> (xAxisConstraint: NSLayoutConstraint, yAxisConstraint: NSLayoutConstraint) {
        return (xAxisPosition.setupPosition(toast: toast, superview: superview), yAxisPosition.setupPosition(toast: toast, superview: superview))
    }
}

public enum XAxisPosition {
    case leading(constant: CGFloat? = nil), center(constant: CGFloat? = nil), trailing(constant: CGFloat? = nil)

    fileprivate func setupPosition(toast: UIButton, superview: UIView) -> NSLayoutConstraint {
        let axisConstraint: NSLayoutConstraint

        switch self {
        case let .leading(constant):
            axisConstraint = toast.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant ?? -toast.bounds.width)
        case let .center(constant):
            axisConstraint = toast.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant ?? 0)
        case let .trailing(constant):
            axisConstraint = toast.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant ?? toast.bounds.width)
        }

        return axisConstraint
    }
}

public enum YAxisPosition {
    case top(constant: CGFloat? = nil), center(constant: CGFloat? = nil), bottom(constant: CGFloat? = nil)

    fileprivate func setupPosition(toast: UIButton, superview: UIView) -> NSLayoutConstraint {
        let axisConstraint: NSLayoutConstraint

        switch self {
        case let .top(constant):
            let defaultConstantValue: CGFloat
            let scene = UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.windowScene
            let statusBarHeight = scene?.statusBarManager?.statusBarFrame.height
            if scene?.interfaceOrientation.isPortrait == true, UIDevice.current.hasNotch, let statusBarHeight = statusBarHeight {
                defaultConstantValue = statusBarHeight - 15
            } else {
                defaultConstantValue = -toast.bounds.height
            }
            axisConstraint = toast.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant ?? defaultConstantValue)
        case let .center(constant):
            axisConstraint = toast.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant ?? 0)
        case let .bottom(constant):
            axisConstraint = toast.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant ?? toast.bounds.height)
        }

        return axisConstraint
    }
}
