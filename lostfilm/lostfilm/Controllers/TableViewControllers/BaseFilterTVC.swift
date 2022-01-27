import UIKit

class BaseFilterTVC: UITableViewController {
    internal var filtersToDisplay: [LFSeriesFilterBaseModel]
    internal var DCwithSelectedFilters: TVSeriesDataController
    
    init(style: UITableView.Style, filtersToDisplay: [LFSeriesFilterBaseModel], DCwithSelectedFilters: TVSeriesDataController) {
        self.filtersToDisplay = filtersToDisplay
        self.DCwithSelectedFilters = DCwithSelectedFilters
        super.init(style: style)
    }

    required init?(coder: NSCoder) {
        filtersToDisplay = []
        DCwithSelectedFilters = TVSeriesDataController()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BaseFilterViewCell.self, forCellReuseIdentifier: BaseFilterViewCell.cellIdentifier())
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "chevron.backward"), style: .plain, target: self, action: #selector(didTransmitFiltersAndPopVC(sender:)))
//        navigationItem.leftBarButtonItem?.title = "Back" // doesn't work
    }
    
//    @objc private func didTransmitFiltersAndPopVC(sender: UIBarButtonItem) {
//        navigationController?.popViewController(animated: true)
//    }

    @objc private func switchFilter(_ sender: UISwitch, filterModel: LFSeriesFilterBaseModel) {
        if sender.isOn {
            DCwithSelectedFilters.add(filter: filterModel)
        } else {
            DCwithSelectedFilters.remove(filter: filterModel)
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let switcher = (self.tableView.cellForRow(at: indexPath)?.accessoryView) as! UISwitch
        if let switcher = (self.tableView.cellForRow(at: indexPath) as! BaseFilterViewCell).switcher {
            switcher.setOn(!switcher.isOn, animated: true)
            switchFilter(switcher, filterModel: filtersToDisplay[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> BaseFilterViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseFilterViewCell.cellIdentifier(), for: indexPath) as! BaseFilterViewCell
        cell.switcher.isOn = DCwithSelectedFilters.savedFilters.contains(filtersToDisplay[indexPath.row]) // setting an initial value for a switch
            cell.textLabel?.text = filtersToDisplay[indexPath.row].name
            cell.switcherAction = { [unowned self] in
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
