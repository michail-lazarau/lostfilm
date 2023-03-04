//
//  ToastSizeLimits.swift
//  WindowToast
//
//  Created by Mikhail Lazarau on 23.01.23.
//

import Foundation
import UIKit

public struct ToastSizeLimits {

    private lazy var screen: UIScreen? = {
        return UIApplication.shared.connectedScenes
            .flatMap({ ($0 as? UIWindowScene)?.windows ?? [] })
            .first(where: { $0 is ToastWindow })?.windowScene?.screen
    }()

     public lazy var maxWidthConstant: [UIUserInterfaceIdiom: CGFloat] = {
        guard let screen = screen else {
            return [:]
        }

        return [.phone: min(screen.bounds.width, screen.bounds.height) - 40,
                .pad: screen.bounds.width / 2]
    }()

    public lazy var minWidthConstant: [UIUserInterfaceIdiom: CGFloat] = {
        guard let screen = screen else {
            return [:]
        }
        return [.phone: 120,
                .pad: screen.bounds.width / 5]
    }()

    public lazy var maxHeightConstant: [UIUserInterfaceIdiom: CGFloat] = {
        guard let screen = screen else {
            return [:]
        }

        return [.phone: screen.bounds.height / 4,
                .pad: screen.bounds.height / 5]
    }()

    public lazy var minHeightConstant: [UIUserInterfaceIdiom: CGFloat] = {
        guard let screen = screen else {
            return [:]
        }

        return [.phone: 48,
                .pad: screen.bounds.height / 10]
    }()
}
