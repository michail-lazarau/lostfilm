import Foundation

protocol TVSeriesDetailsPaginatingDC_Delegate: AnyObject {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?)
}
