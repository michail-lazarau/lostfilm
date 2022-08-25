import Foundation

protocol IUpdatingViewByPageDelegate: AnyObject {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?)
}
