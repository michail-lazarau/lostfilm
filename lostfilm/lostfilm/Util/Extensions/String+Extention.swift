//
//  String+Extention.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-10-27.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
