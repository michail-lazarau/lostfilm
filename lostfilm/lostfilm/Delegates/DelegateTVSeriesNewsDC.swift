import Foundation

protocol DelegateTVSeriesNewsDC: AnyObject {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?)
}
