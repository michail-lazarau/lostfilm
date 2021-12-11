import UIKit

class SeriesTableViewController: UITableViewController, DataControllerDelegate {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dataSource = nil
    }

    init(style: UITableView.Style, dataController: DataController) {
        super.init(style: style)
        dataSource = dataController
        dataSource?.delegate = self
    }

    fileprivate let tableFooterHeight: CGFloat = 50
    fileprivate let tableCellHeight: CGFloat = 175
    private var dataSource: DataController?

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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TV Series"
        
        setupTableViewController()
    }

    func setupTableViewController() {
        tableView.register(SeriesViewCell.self, forCellReuseIdentifier: SeriesViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    // MARK: out of use
    func destroyTableFooter() {
        tableView.tableFooterView = nil
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.tableFooterView?.isHidden = false // MARK: displays UIActivityIndicatorView before table is updated
    }
}
// MARK: - Table view delegate
extension SeriesTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
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
}

// MARK: - Scroll view delegate
extension SeriesTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y + tableView.frame.size.height
        let maximumOffset = scrollView.contentSize.height - tableFooterHeight
        let deltaOffset = maximumOffset - currentOffset
        if deltaOffset <= 0 {
            dataSource?.LoadingData()
            tableView.tableFooterView?.isHidden = true // MARK: hides UIActivityIndicatorView when table is updated
        }
    }
}

// MARK: - Table view data source
extension SeriesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = dataSource?.count else { return 0 }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeriesViewCell.cellIdentifier, for: indexPath) as! SeriesViewCell
        if let model = dataSource?[indexPath.row] {
            cell.configureWith(dataModel: model)
        }
        return cell
    }
}

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
 }
 */
