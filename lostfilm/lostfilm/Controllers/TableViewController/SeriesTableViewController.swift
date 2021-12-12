import UIKit

class SeriesTableViewController: TableViewControllerTemplate<SeriesViewCell> {

    fileprivate let tableCellHeight: CGFloat = 175
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TV Series"
    }
}

// MARK: - Table view delegate
extension SeriesTableViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
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
}
