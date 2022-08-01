import UIKit

class TemplateTVC<Cell, DataModel>: UITableViewController, DataControllerDelegate where Cell: CellConfigurable, DataModel: LFJsonObject {
    fileprivate let tableFooterHeight: CGFloat = 50
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    internal var tableCellHeight: CGFloat {
        return 0
    }

    internal var dataSource: TemplateDataController<DataModel>?

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(style: UITableView.Style, dataController: TemplateDataController<DataModel>) {
        super.init(style: style)
        dataSource = dataController
        dataSource!.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewController()
    }

    func setupTableViewController() {
        registerCell()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    func registerCell() {
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }

    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        dataSource?.DidEmptyItemList()
        tableView.reloadData()
        dataSource?.LoadingData()
        sender.endRefreshing()
    }

    func updateUIForTableWith(rowsRange: Range<Int>) {
        if rowsRange.isEmpty {
            return spinner.stopAnimating()
        }
        
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
        spinner.stopAnimating()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.tableFooterView?.isHidden = false // MARK: displays UIActivityIndicatorView before table is updated
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: UIScreen.main.bounds.width,
                                              height: tableFooterHeight))
        footerView.backgroundColor = .clear
        spinner.center = footerView.center
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
            spinner.startAnimating() // MARK: must be inside the loadingData() to follow the looped calling
            dataSource?.LoadingData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        if let model = dataSource?[indexPath.row] {
            cell.configureWith(dataModel: model as! Cell.DataModel)
        }
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = dataSource?.count else { return 0 }
        return count
    }
}
