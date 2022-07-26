import UIKit

class TVSeriesNewsTVC: UITableViewController, UITableViewDataSourcePrefetching {
    var viewModel: NewsVM
    fileprivate let tableFooterHeight: CGFloat = 50

    init(style: UITableView.Style, viewModel: NewsVM) {
        self.viewModel = viewModel
        super.init(style: style)
        self.viewModel.dataProvider?.delegate = self
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.dataSource = viewModel
        tableView.prefetchDataSource = self // MARK: no scrolling over the 1st backet otherwise
        viewModel.dataProvider?.loadItemsByPage()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    private func registerCells() {
        tableView.register(SeriesNewsViewCell.nib, forCellReuseIdentifier: SeriesNewsViewCell.reuseIdentifier)
    }

    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        viewModel.dataProvider?.didEmptyNewsList()
        viewModel.dataProvider?.loadItemsByPage()
        sender.endRefreshing()
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - DataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.dataProvider?.loadItemsByPage()
        }
    }
}

// MARK: - Source https://www.raywenderlich.com/5786-uitableview-infinite-scrolling-tutorial

private extension TVSeriesNewsTVC {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let lastVisibleRow = tableView.indexPathsForVisibleRows?.last?.row else {
            return false
        }
        return lastVisibleRow >= viewModel.rowCount - 1
    }
}

extension TVSeriesNewsTVC: DelegateTVSeriesDCwithPagination {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.reloadData()
            return
        }
        tableView.insertRows(at: newIndexPathsToReload, with: .automatic)
    }
}
