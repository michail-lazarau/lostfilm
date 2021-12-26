import UIKit

class ScheduleTableViewController: UITableViewController, ScheduleDataControllerDelegate {
    
    fileprivate let tableFooterHeight: CGFloat = 50
    
    private let sections: [ScheduleDateInterval] = [.today, .tomorrow, .thisWeek, .nextWeek, .later]
    
    internal var tableCellHeight: CGFloat {
        return 144
    }
    
    internal var dataSource: ScheduleDataController?
    
    init(style: UITableView.Style, dataController: ScheduleDataController) {
        super.init(style: style)
        dataSource = dataController
        dataSource!.delegate = self
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

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        dataSource?.getSchedule()
        sender.endRefreshing()
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
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewEpisodeViewCell.cellIdentifier(), for: indexPath) as! NewEpisodeViewCell
        if let models = dataSource?.selectItemsWithin(dateInterval: sections[indexPath.section]) {
            let offset = models.startIndex
            let model = models[indexPath.row - offset]
            cell.configureWith(dataModel: model)
        }
//        if let model = dataSource?.selectItemsWithin(dateInterval: sections[indexPath.section])[indexPath.row] {
//            cell.configureWith(dataModel: model )
//        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.selectItemsWithin(dateInterval: sections[section]).count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .today:
            return "Сегодня"
        case .tomorrow:
            return "Завтра"
        case .thisWeek:
            return "На этой неделе"
        case .nextWeek:
            return "На следующей неделе"
        case .later:
            return "Позже"
        }
    }
}
