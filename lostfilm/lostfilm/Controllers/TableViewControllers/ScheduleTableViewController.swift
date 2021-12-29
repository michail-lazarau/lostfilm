import UIKit

class ScheduleTableViewController: UITableViewController, ScheduleDataControllerDelegate {
    internal var dataSource: ScheduleDataController?
    // MARK: delete code below it later
    internal var dataSourceOfFiltering: FilteringDataController = FilteringDataController()

    init(style: UITableView.Style, dataController: ScheduleDataController) {
        super.init(style: style)
        dataSource = dataController
        dataSource!.delegate = self
        
        // MARK: delete code below it later
        dataSourceOfFiltering.getFilters()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dataSource = nil
    }

    func updateUIForTimeTable() {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewController()
        navigationItem.title = "Schedule"

        dataSource?.getSchedule()
    }

    func setupTableViewController() {
        tableView.register(NewEpisodeViewCell.self, forCellReuseIdentifier: NewEpisodeViewCell.cellIdentifier())
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        self.tableView.contentInsetAdjustmentBehavior = .never

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        dataSource?.DidEmptyItemList()
        dataSource?.getSchedule()
        tableView.reloadData()
        sender.endRefreshing()
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewEpisodeViewCell.cellIdentifier(), for: indexPath) as! NewEpisodeViewCell

        if let model = dataSource?[indexPath.section, indexPath.row] {
            cell.configureWith(dataModel: model)
        }
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.sectionsCount ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?[section].count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Сегодня"
        case 1:
            return "Завтра"
        case 2:
            return "На этой неделе"
        case 3:
            return "На следующей неделе"
        case 4:
            return "Позже"
        default:
            return "Error"
        }
    }
}
