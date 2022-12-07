//
//  DebouncerProtocol.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-29.
//

import Foundation

protocol DebouncerProtocol {
    func debounce(handler: @escaping (() -> Void))
}
