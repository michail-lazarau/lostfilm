import UIKit

class TVSeriesNewsTVC: UITableViewController, IUpdatingViewByPageDelegate, UITableViewDataSourcePrefetching {
    let viewModel: NewsVM
    fileprivate let tableFooterHeight: CGFloat = 50
    
    private let initialScreenLoadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var noDataScreenLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        label.text = "No Data Found."
        label.textColor = UIColor.red
        label.textAlignment = .center
        return label
    }()
    
    init(style: UITableView.Style, viewModel: NewsVM) {
        self.viewModel = viewModel
        super.init(style: style)
        viewModel.delegate = self
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.dataSource = viewModel
        tableView.prefetchDataSource = self // MARK: otherwise, there's no scrolling beyond the 1st backet
        tableView.backgroundView = initialScreenLoadingSpinner
        initialScreenLoadingSpinner.startAnimating()
        viewModel.loadItemsByPage()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    private func registerCells() {
        tableView.register(SeriesNewsViewCell.nib, forCellReuseIdentifier: SeriesNewsViewCell.reuseIdentifier)
    }
    
    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        viewModel.didEmptyItemList()
        tableView.reloadData()
        viewModel.loadItemsByPage()
        sender.endRefreshing()
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let lastVisibleRow = tableView.indexPathsForVisibleRows?.last?.row else {
            return false
        }
        return lastVisibleRow >= viewModel.items.count - 1
    }
    
    // MARK: TVSeriesDetailsPaginatingDC_Delegate

        func updateTableView(with newIndexPathsToReload: [IndexPath]?) {
            if let newIndexPathsToReload = newIndexPathsToReload {
                tableView.insertRows(at: newIndexPathsToReload, with: .automatic)
            } else {
                tableView.reloadData()
            }
            if viewModel.items.count == 0 {
                tableView.backgroundView = noDataScreenLabel
            } else {
                tableView.backgroundView = nil // MARK: destroying initialScreenLoadingSpinner
            }
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
            viewModel.loadItemsByPage()
        }
    }
}
