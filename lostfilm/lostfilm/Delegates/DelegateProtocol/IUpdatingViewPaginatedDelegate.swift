import Foundation

protocol IUpdatingViewPaginatedDelegate: AnyObject {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?)
}
