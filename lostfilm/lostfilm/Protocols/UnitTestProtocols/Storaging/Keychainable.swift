import Foundation
import KeychainAccess

protocol Keychainable {
    func get(_ key: String, ignoringAttributeSynchronizable: Bool) throws -> String?
    func set(_ value: String, key: String, ignoringAttributeSynchronizable: Bool) throws
}

extension Keychain: Keychainable { }
