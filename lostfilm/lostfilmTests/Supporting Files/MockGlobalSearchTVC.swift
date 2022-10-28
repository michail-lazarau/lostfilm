import Foundation
@testable import lostfilm

class MockGlobalSearchTVC: NSObject, IUpdatingViewDelegate {
    @objc dynamic var didUpdateTableViewCalled: Bool = false

    func updateView() {
        if didUpdateTableViewCalled == true {
            fatalError("[didUpdateTableViewCalled] has been already [true]")
        }
        didUpdateTableViewCalled = true
    }
}
