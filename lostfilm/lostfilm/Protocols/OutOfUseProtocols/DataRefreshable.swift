//
//  DataRefreshable.swift
//  lostfilm
//
//  Created by Mikhail Lazarau on 4.08.22.
//

import Foundation

// FIXME: OUT OF USE - DELETE PROTOCOL LATER
@objc protocol DataRefreshable {
    dynamic func pullToRefresh(_ sender: UIRefreshControl)
}

extension DataRefreshable where Self: UITableViewController {
    func didSetupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
}

//extension DataRefreshable {
//    func pullToRefresh(_ sender: UIRefreshControl) {
//        sender.endRefreshing()
//    }
//}

// extension DataRefreshable where Self: PaginatedDataLoadable{
//    func pullToRefresh(_ sender: UIRefreshControl) {
//        viewModel.dataProvider?.didEmptyItemList()
//        viewModel.dataProvider?.didLoadItemsByPage()
//        sender.endRefreshing()
//    }
// }
