import UIKit

class TVSeriesNewsTVC: UITableViewController, DelegateTVSeriesNewsDC, UITableViewDataSourcePrefetching {
    var viewModel: NewsVM
    fileprivate let tableFooterHeight: CGFloat = 50

    init(style: UITableView.Style, viewModel: NewsVM) {
        self.viewModel = viewModel
        super.init(style: style)
        self.viewModel.dataProvider?.delegate = self
    }

    required init?(coder: NSCoder) {
        viewModel = NewsVM()
        super.init(coder: coder)
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.dataSource = viewModel
        tableView.prefetchDataSource = self
//        viewModel.dataProvider?.loadDataByPage()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    func updateTableViewWith(newsList: [LFNewsModel]) {
//        if let newsList = viewModel.dataProvider?.newsList { // MARK: refactor this - put this code inside of dataProvider if there's no reason to leave here
//            viewModel.setupVMwith(modelList: newsList)
//        }
        let rowsRange = viewModel.setupVMwith(modelList: newsList)
        
        if rowsRange.isEmpty { tableView.tableFooterView?.isHidden = true
            return
        } // MARK: i dont see a reason for using destroyTableFooter()

        let isListEmpty = (rowsRange.lowerBound == 0)
        if isListEmpty {
            tableView.reloadData()
        } else {
            var array: [IndexPath] = []
            for index in rowsRange {
                array.append(IndexPath(row: index, section: 0))
            }
            tableView.insertRows(at: array, with: .bottom)
        }
    }

    func registerCells() {
        tableView.register(SeriesNewsViewCell.nib, forCellReuseIdentifier: SeriesNewsViewCell.reuseIdentifier)
    }

    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        // TODO: reloadData logics
        viewModel.didEmptyNewsList()
        viewModel.dataProvider?.loadDataByPage()
        sender.endRefreshing()
    }
    
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: tableFooterHeight)) // MARK: is UIScreen.main.bounds.width ok?

        footerView.backgroundColor = .clear
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        spinner.center = footerView.center
        spinner.startAnimating()
        footerView.addSubview(spinner)
        tableView.tableFooterView = footerView // works as well: = spinner
        return footerView
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        tableView.tableFooterView?.isHidden = false // MARK: displays UIActivityIndicatorView before table is updated
//    }

    // MARK: - Scroll view delegate

//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        let height = scrollView.frame.size.height
////        let contentYoffset = scrollView.contentOffset.y
////        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
////        if distanceFromBottom < height {
////            viewModel.dataProvider?.loadDataByPage()
////            tableView.tableFooterView?.isHidden = true // MARK: hides UIActivityIndicatorView when table is updated
////        }
//        let currentOffset = scrollView.contentOffset.y + tableView.frame.size.height
//        let maximumOffset = scrollView.contentSize.height - tableFooterHeight
//        let deltaOffset = maximumOffset - currentOffset
//        if deltaOffset <= 0 {
//            viewModel.dataProvider?.loadDataByPage()
//            tableView.tableFooterView?.isHidden = true // MARK: hides UIActivityIndicatorView when table is updated
//        }
//    }
    
    // MARK: - DataSourcePrefetching
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.dataProvider?.loadDataByPage()
        }
    }
}
    // MARK: - Source https://www.raywenderlich.com/5786-uitableview-infinite-scrolling-tutorial
private extension TVSeriesNewsTVC {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
      return indexPath.row >= viewModel.items.first?.rowCount ?? 0
  }

  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}
