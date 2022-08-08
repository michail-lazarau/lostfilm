import Foundation

// @objc is for mocking objects in UnitTests
@objc protocol IUpdatingViewDelegate: AnyObject {
    func updateTableView()
}
