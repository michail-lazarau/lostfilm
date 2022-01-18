import UIKit

class BaseFilterTVC: UITableViewController {
    internal var dataSource: [LFSeriesFilterBaseModel]?
    var baseFilterDelegate: BaseFilterDelegate?
    private var appliedFilters: [LFSeriesFilterBaseModel]
    
    init(style: UITableView.Style, dataController: [LFSeriesFilterBaseModel], appliedFilters: [LFSeriesFilterBaseModel]) {
        self.appliedFilters = appliedFilters
        super.init(style: style)
        dataSource = dataController
//        dataSource!.delegate = self
    }

    required init?(coder: NSCoder) {
        appliedFilters = []
        super.init(coder: coder)
        dataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BaseFilterViewCell.self, forCellReuseIdentifier: BaseFilterViewCell.cellIdentifier())
        let backButton = UIBarButtonItem(image: UIImage(named: "chevron.backward"), style: .plain, target: self, action: #selector(sendFilters(sender:)))
        backButton.title = "Back"
        navigationItem.leftBarButtonItem = backButton
//        navigationItem.backBarButtonItem?.action = #selector(sendFilters(sender:))
    }
    
    @objc private func sendFilters(sender: UIBarButtonItem) {
            baseFilterDelegate?.sendFiltersToFilteringTVC(filters: appliedFilters)
        navigationController?.popViewController(animated: true)
    }

    @objc private func switchFilter(_ sender: UISwitch, filterModel: LFSeriesFilterBaseModel) {
        if sender.isOn {
            appliedFilters.append(filterModel)
        } else {
            if let index = appliedFilters.firstIndex(of: filterModel) {
                appliedFilters.remove(at: index)
            }
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filterModel = dataSource?[indexPath.row]
        else { return }
        //        let switcher = (self.tableView.cellForRow(at: indexPath)?.accessoryView) as! UISwitch
        if let switcher = (self.tableView.cellForRow(at: indexPath) as! BaseFilterViewCell).switcher {
            switcher.setOn(!switcher.isOn, animated: true)
            switchFilter(switcher, filterModel: filterModel)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> BaseFilterViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseFilterViewCell.cellIdentifier(), for: indexPath) as! BaseFilterViewCell
        if let filterModel = dataSource?[indexPath.row] {
            // switcher.isOn - засетай начальное состояние!
            cell.switcher.isOn = appliedFilters.contains(filterModel)
            cell.textLabel?.text = filterModel.name
            cell.switcherAction = { [unowned self] in
                switchFilter(cell.switcher, filterModel: filterModel)
            }
        }
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
