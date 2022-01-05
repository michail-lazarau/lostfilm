import UIKit

class BaseFilterTVC: UITableViewController {
    internal var dataSource: [LFSeriesFilterBaseModel]?
    
    init(style: UITableView.Style, dataController: [LFSeriesFilterBaseModel]) {
        super.init(style: style)
        dataSource = dataController
//        dataSource!.delegate = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BaseFilterTVCCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseFilterTVCCell", for: indexPath)
        cell.textLabel?.text = dataSource?[indexPath.row].name
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
