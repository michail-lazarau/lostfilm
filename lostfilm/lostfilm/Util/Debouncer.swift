//
//  Debouncer.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-28.
//

import Foundation

class Debouncer: DebouncerProtocol {
    func debounce(handler: @escaping (() -> Void)) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { (timer) in
            guard timer.isValid else { return }
            handler()
        })
    }

    private let timeInterval: TimeInterval
    private var timer: Timer?

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
}
