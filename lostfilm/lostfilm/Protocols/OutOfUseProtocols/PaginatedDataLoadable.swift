import Foundation
import UIKit

// FIXME: OUT OF USE - DELETE PROTOCOL LATER
protocol PaginatedDataLoadable: IUpdatingViewByPageDelegate {
//    associatedtype ViewModelContentable: ViewModelable
//    var viewModel: ViewModelContentable { get set }
//    var dataView: PaginatedDataViewable { get }
}

// MARK: - Source https://www.raywenderlich.com/5786-uitableview-infinite-scrolling-tutorial
//
// extension PaginatedDataLoadable where Self: UITableViewController {
//    var dataView: PaginatedDataViewable {
//        tableView
//    }
// }
//
// extension PaginatedDataLoadable where Self: UICollectionViewController {
//    var dataView: PaginatedDataViewable {
//        collectionView
//    }
// }
//
//
//// extension UITableViewDataSourcePrefetching where Self: PaginatedDataLoadable, Self: UIViewController {
////    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
////        if indexPaths.contains(where: isLoadingCell) {
////            viewModel.dataProvider?.didLoadItemsByPage()
////        }
////    }
//// }
//
//// extension PaginatedDataLoadable where Self: DataRefreshable {
////    dynamic func pullToRefresh(_ sender: UIRefreshControl) {
////        viewModel.dataProvider?.didEmptyItemList()
////        viewModel.dataProvider?.didLoadItemsByPage()
////        sender.endRefreshing()
////    }
//// }
//
// extension PaginatedDataLoadable where Self: UIViewController {
//    func isLoadingCell(for indexPath: IndexPath) -> Bool {
//        guard let lastVisibleRow = dataView.lastVisibleRow else {
//            return false
//        }
//        return lastVisibleRow >= viewModel.itemCount - 1
//    }
// }
//
// MARK: TVSeriesDetailsPaginatingDC_Delegate
//
// extension PaginatedDataLoadable {
//    func updateTableView(with newIndexPathsToReload: [IndexPath]?) {
//        guard let newIndexPathsToReload = newIndexPathsToReload else {
//            dataView.reloadData()
//            return
//        }
//        dataView.insertObjects(at: newIndexPathsToReload)
//    }
// }

// MARK: solution with opaque type https://stackoverflow.com/questions/50408628/protocol-can-an-only-be-used-as-a-generic-constraint-because-it-has-self-or-asso

// MARK: https://zamzam.io/protocol-oriented-tableview-collectionview/
