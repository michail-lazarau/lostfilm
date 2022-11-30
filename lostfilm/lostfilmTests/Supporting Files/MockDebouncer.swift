//
//  MockDebouncer.swift
//  lostfilmTests
//
//  Created by u.yanouski on 2022-11-29.
//

@testable import lostfilm
import Foundation

class MockDebouncer: DebouncerProtocol {

    func debounce(handler: @escaping (() -> Void)) {
        handler()
    }
    
}
