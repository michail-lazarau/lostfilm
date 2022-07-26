import UIKit

class TVSeriesVideosTVC: UITableViewController, UITableViewDataSourcePrefetching {
    var viewModel: VideosVM
    
    init(style: UITableView.Style, viewModel: VideosVM) {
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
        tableView.prefetchDataSource = self
        viewModel.dataProvider?.loadItemsByPage()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    private func registerCells() {
        tableView.register(VideoViewCell.self, forCellReuseIdentifier: VideoViewCell.reuseIdentifier)
    }
    
    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        viewModel.dataProvider?.didEmptyNewsList()
        viewModel.dataProvider?.loadItemsByPage()
        sender.endRefreshing()
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width / 16 * 9
    }

    // MARK: - DataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.dataProvider?.loadItemsByPage()
        }
    }
}

// MARK: - Source https://www.raywenderlich.com/5786-uitableview-infinite-scrolling-tutorial

private extension TVSeriesVideosTVC {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let lastVisibleRow = tableView.indexPathsForVisibleRows?.last?.row else {
            return false
        }
        return lastVisibleRow >= viewModel.rowCount - 1
    }
}

extension TVSeriesVideosTVC: DelegateTVSeriesDCwithPagination {
    func updateTableView(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.reloadData()
            return
        }
        tableView.insertRows(at: newIndexPathsToReload, with: .automatic)
    }
}
