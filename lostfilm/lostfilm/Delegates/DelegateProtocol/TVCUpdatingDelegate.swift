import Foundation

// @objc is for mocking objects in UnitTests
@objc protocol TVCUpdatingDelegate: AnyObject {
    func updateTableView()
}
