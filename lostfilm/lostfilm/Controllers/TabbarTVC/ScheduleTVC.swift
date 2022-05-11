import UIKit

class ScheduleTVC: UITableViewController, ScheduleDataControllerDelegate {
    private let sections: [String] = ["Сегодня", "Завтра", "На этой неделе", "На следующей неделе", "Позже"]
    internal var dataSource: ScheduleDataController?

    init(style: UITableView.Style, dataController: ScheduleDataController) {
        super.init(style: style)
        dataSource = dataController
        dataSource!.delegate = self
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        tableView.register(NewEpisodeViewCell.self, forCellReuseIdentifier: NewEpisodeViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        self.tableView.contentInsetAdjustmentBehavior = .never

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        dataSource?.DidEmptyItemList()
        dataSource?.getSchedule()
        tableView.reloadData() // TODO: remove and check
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
        let cell = tableView.dequeueReusableCell(withIdentifier: NewEpisodeViewCell.reuseIdentifier, for: indexPath) as! NewEpisodeViewCell

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
        sections[section]
    }
}
