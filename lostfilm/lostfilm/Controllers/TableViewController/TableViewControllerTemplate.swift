import UIKit

class TableViewControllerTemplate<T>: UITableViewController, DataControllerDelegate where T: CellConfigurable {

    fileprivate let tableFooterHeight: CGFloat = 50
    internal var dataSource: DataController?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dataSource = nil
    }
    
    init(style: UITableView.Style, dataController: DataController) {
        super.init(style: style)
        dataSource = dataController
        dataSource?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewController()
    }
    
    func setupTableViewController() {
        let cellType = T.self
        let cellIdentifier = String(describing: type(of: cellType))
        
        tableView.register(cellType, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        // TODO: reloadData logics
        dataSource?.DidEmptySeriesList()
        dataSource?.LoadingData()
        sender.endRefreshing()
    }
    
    func updateUIForTableWith(rowsRange: Range<Int>) {
        if rowsRange.isEmpty
        { tableView.tableFooterView?.isHidden = true
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.tableFooterView?.isHidden = false // MARK: displays UIActivityIndicatorView before table is updated
    }
    
    
    // MARK: - Table view delegate
    
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
    
    
    // MARK: - Scroll view delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y + tableView.frame.size.height
        let maximumOffset = scrollView.contentSize.height - tableFooterHeight
        let deltaOffset = maximumOffset - currentOffset
        if deltaOffset <= 0 {
            dataSource?.LoadingData()
            tableView.tableFooterView?.isHidden = true // MARK: hides UIActivityIndicatorView when table is updated
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = T.self
        let cellIdentifier = String(describing: type(of: cellType))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! T
        if let model = dataSource?[indexPath.row] {
            cell.configureWith(dataModel: model as! T.DataModel)
        }
        return cell
    }
}
