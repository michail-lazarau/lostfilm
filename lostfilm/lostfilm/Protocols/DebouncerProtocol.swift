//
//  DebouncerProtocol.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-29.
//

import Foundation


protocol DebouncerProtocol {
    // add debounce func  и передать клоужер bounds как параметр функции
    func debounce(handler: @escaping (() -> Void))
}
