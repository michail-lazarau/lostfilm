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

    private var dataSource: DataController?

    @objc private func pullToRefresh(_ sender: UIRefreshControl) {
        // TODO: reloadData logics
        // dataSource?.getNextItemList() - проверить вызов именно этого метода у Дениса.
        // релизовать пагинацию вызова (страница +1), но вызывать только первую страницу по вызову pullToRefresh
        // убедиться, что я понимаю как работают делегаты
        sender.endRefreshing()
    }

    func updateUIForTable() {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        dataSource?.getNextItemList()
        setupTableViewController()
    }

    func setupTableViewController() {
        tableView.register(SeriesViewCell.self, forCellReuseIdentifier: SeriesViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }

    // MARK: - Table view data source

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
}
