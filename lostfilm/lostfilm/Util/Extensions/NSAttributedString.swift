//
//  NSAttributedString.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-04.
//

import Foundation

extension NSAttributedString {

    static func  createHyperlink(for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: substringRange  )
        return attributedString
    }
}
