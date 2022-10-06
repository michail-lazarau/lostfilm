//
//  UIColor+Extension.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-10-06.
//

import Foundation

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static let lightBG = UIColor.rgb(red: 217, green: 219, blue: 234)
    static let darkBG = UIColor.rgb(red: 17, green: 37, blue: 50)
}
