//
//  UITextView+Extension.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-12-07.
//

import Foundation

extension UITextView {
    func hyperLink(originalText: String, hyperLink: String, urlString: String) {

        let style = NSMutableParagraphStyle()
        style.alignment = .left

        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange =  NSRange(location: 0, length: attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 10), range: fullRange)

        self.linkTextAttributes = [
            kCTForegroundColorAttributeName: UIColor.blue,
            kCTUnderlineStyleAttributeName: NSUnderlineStyle.single.rawValue
        ] as [NSAttributedString.Key: Any]

        self.attributedText = attributedOriginalText
    }
}
