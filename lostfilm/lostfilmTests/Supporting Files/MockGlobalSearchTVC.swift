import Foundation
@testable import lostfilm

class MockGlobalSearchTVC: DelegateGlobalSearchDC {
    var didUpdateTableViewCalled: Bool = false
    
    func updateTableView() {
        if didUpdateTableViewCalled == true {
            fatalError("[didUpdateTableViewCalled] has been already [true]")
        }
        didUpdateTableViewCalled = true
    }
    
    
}
