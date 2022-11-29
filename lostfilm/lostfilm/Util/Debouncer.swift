//
//  Debouncer.swift
//  lostfilm
//
//  Created by u.yanouski on 2022-11-28.
//

import Foundation

public class Debouncer {

    private let timeInterval: TimeInterval
    private var timer: Timer?

    var handler: (() -> Void)?

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    public func renewInterval() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] (timer) in
            self?.timeIntervalDidFinish(for: timer)
        })
    }

    @objc private func timeIntervalDidFinish(for timer: Timer) {
        guard timer.isValid else {
            return
        }

        handler?()
        handler = nil
    }
}
