//
//  Queue.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 2.01.23.
//

import Foundation

// https://medium.com/@JoyceMatos/data-structures-in-swift-queues-and-stacks-e7d715634f07
struct Queue<T> {
    private var list = [T]()

    // MARK: - Operations

    mutating func enqueue(_ element: T) {
        list.append(element)
    }

    mutating func dequeue() -> T? {
        guard !list.isEmpty else {
            return nil
        }

        return list.removeFirst()
    }

    func peek() -> T? {
        guard !list.isEmpty else {
            return nil
        }

        return list[0]
    }
}
