import UIKit

class BaseFilterTVC: UITableViewController {
    internal var filtersToDisplay: [LFSeriesFilterBaseModel]
    internal var dcWithSelectedFilters: TVSeriesDataController

    init(style: UITableView.Style, filtersToDisplay: [LFSeriesFilterBaseModel], DCwithSelectedFilters: TVSeriesDataController) {
        self.filtersToDisplay = filtersToDisplay
        dcWithSelectedFilters = DCwithSelectedFilters
        super.init(style: style)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BaseFilterViewCell.self, forCellReuseIdentifier: BaseFilterViewCell.reuseIdentifier)
    }

    @objc private func switchFilter(_ sender: UISwitch, filterModel: LFSeriesFilterBaseModel) {
        if sender.isOn {
            dcWithSelectedFilters.add(filter: filterModel)
        } else {
            dcWithSelectedFilters.remove(filter: filterModel)
        }
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let switcher = (self.tableView.cellForRow(at: indexPath)?.accessoryView) as! UISwitch
        if let switcher = (self.tableView.cellForRow(at: indexPath) as? BaseFilterViewCell)?.switcher {
            switcher.setOn(!switcher.isOn, animated: true)
            switchFilter(switcher, filterModel: filtersToDisplay[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BaseFilterViewCell.reuseIdentifier, for: indexPath) as? BaseFilterViewCell else {
            return UITableViewCell()
        }

        cell.switcher.isOn = dcWithSelectedFilters.savedFilters.contains(filtersToDisplay[indexPath.row]) // setting an initial value for a switch
        cell.textLabel?.text = filtersToDisplay[indexPath.row].name
        cell.switcherCallback = { [unowned self] in
            switchFilter(cell.switcher, filterModel: filtersToDisplay[indexPath.row])
        }

        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtersToDisplay.count
    }
}
