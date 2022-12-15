import Foundation
@testable import lostfilm
import XCTest

class KeychainMock: Keychainable {
    private var attributes: [String: String] = [:]

    func get(_ key: String, ignoringAttributeSynchronizable: Bool) throws -> String? {
        return attributes[key]
    }

    func set(_ value: String, key: String, ignoringAttributeSynchronizable: Bool) throws {
        attributes[key] = value
    }
}
