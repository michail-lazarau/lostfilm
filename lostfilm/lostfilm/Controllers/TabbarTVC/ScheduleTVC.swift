import UIKit

class ScheduleTVC: UITableViewController, ScheduleViewProtocol {

    private let sections: [String] = ["Сегодня", "Завтра", "На этой неделе", "На следующей неделе", "Позже"]
    let dataController: ScheduleDataController

    init(style: UITableView.Style, dataController: ScheduleDataController) {
        self.dataController = dataController
        super.init(style: style)
        dataController.delegate = self
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView() {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewController()
        navigationItem.title = "Schedule"

        dataController.getSchedule()
    }

    func setupTableViewController() {
        tableView.register(NewEpisodeViewCell.self, forCellReuseIdentifier: NewEpisodeViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        self.tableView.contentInsetAdjustmentBehavior = .never

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }

    func showProfileButton(with username: String) {
        let button = ProfileButton(title: username, titleColor: UIColor.white, backgroundColor: UIColor(named: "button"))
        button.addTarget(self, action: #selector(profileButtonAction), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        item.accessibilityIdentifier = "profileButton"
        var buttons = navigationItem.rightBarButtonItems?.filter { $0.accessibilityIdentifier != "signInButton" } ?? []
        buttons.append(item)
        navigationItem.setRightBarButtonItems(buttons, animated: false)
    }

    func showSignedOutProfileButton() {
        let item = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(loginButtonAction))
        item.accessibilityIdentifier = "signInButton"
        var buttons = navigationItem.rightBarButtonItems?.filter { $0.accessibilityIdentifier != "profileButton" } ?? []
        buttons.append(item)
        navigationItem.setRightBarButtonItems(buttons, animated: false)
    }

    @objc private func profileButtonAction() {
        dataController.didTapProfileButton()
    }

    @objc private func loginButtonAction() {
        dataController.didTapSignInButton()
    }

    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        dataController.DidEmptyItemList()
        dataController.getSchedule()
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
        return .leastNormalMagnitude
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewEpisodeViewCell.reuseIdentifier, for: indexPath) as? NewEpisodeViewCell else {
            return UITableViewCell()
        }

        let model = dataController[indexPath.section, indexPath.row]
        cell.configureWith(dataModel: model)
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataController.sectionsCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
}
