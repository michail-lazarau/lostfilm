import Foundation

protocol DelegateTVSeriesDCwithPagination: AnyObject {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?)
}
