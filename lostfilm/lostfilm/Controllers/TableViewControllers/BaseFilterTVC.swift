import UIKit

class BaseFilterTVC: UITableViewController {
    internal var dataSource: [LFSeriesFilterBaseModel]?
    private var delegate: BaseFilterDelegate?
    private var filterSet: (key: String, values: Set<String>)?
    
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
        navigationItem.backBarButtonItem?.action = #selector(sendFilters(sender:))
        //        presentingVC - pass data?
    }
    
    @objc private func sendFilters(sender: UIBarButtonItem) {
        if let filterSet = filterSet {
            delegate?.sendFiltersToTVSeriesTVC(filters: filterSet)
        }
    }

    @objc private func switchFilter(_ sender: UISwitch, filterModel: LFSeriesFilterBaseModel) {
        if filterSet == nil {
            filterSet = (filterModel.key, Set<String>.init())
        }

        if sender.isOn {
            filterSet?.values.insert(filterModel.value)
        } else {
            filterSet?.values.remove(filterModel.value)
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filterModel = dataSource?[indexPath.row]
        else { return }
        let switcher = (self.tableView.cellForRow(at: indexPath)?.accessoryView) as! UISwitch
        switcher.setOn(!switcher.isOn, animated: true)
        switchFilter(switcher, filterModel: filterModel)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseFilterTVCCell", for: indexPath)
        let filterModel = dataSource?[indexPath.row]
        cell.textLabel?.text = filterModel?.name
        let switcher = UISwitch()
//        TODO: switcher.isOn - засетай начальное состояние!
        cell.accessoryView = switcher
        switcher.addTarget(self, action: #selector(switchFilter(_:filterModel:)), for: .valueChanged)
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
