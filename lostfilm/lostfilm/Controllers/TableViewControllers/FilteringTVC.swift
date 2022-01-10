import UIKit

class FilteringTVC: UITableViewController, FilteringDataControllerDelegate, BaseFilterDelegate {
    private let sections: [String] = ["Сортировка", "Фильтр"]
    private let sectionCells: [[String]] = [["Сортировать"], ["Статус", "Жанр", "Год выхода", "Канал", "Тип"]]
    internal var dataSource: FilteringDataController?
    internal var filterDictionary: [String : Set<String>]?
    
    init(style: UITableView.Style, dataController: FilteringDataController, filterDictionary: [String : Set<String>]?) {
        super.init(style: style)
        dataSource = dataController
        dataSource!.delegate = self
        self.filterDictionary = filterDictionary
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilteringTVCCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "xmark"), style: .plain, target: self, action: #selector(DidViewControllerDismiss))
        navigationItem.title = "Сортировка и фильтр"
        dataSource?.getFilters()
    }
    
    @objc func DidViewControllerDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    func sendFiltersToFilteringTVC(filters: (key: String, values: Set<String>)) {
        if filterDictionary == nil {
            filterDictionary = [:]
        }
        
        filterDictionary?.merge([filters.key : filters.values]) { _, new in new }
    }
    
    func callMe() {
//        <#code#>
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let baseFilters = dataSource?.filtersModel else {
            return
        }
        
        let controller: BaseFilterTVC
        let filterSet: (String, Set<String>)?
        
        switch sectionCells[indexPath.section][indexPath.row] {
//        case "Сортировать": controller = BaseFilterTVC(style: .plain, dataController: dataSource?.filtersModel.)
        case "Статус":
            filterSet = filterDictionary?.first{$0.key == dataSource?.filtersModel?.types.first?.key}
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.types, filterSet: filterSet)
            controller.navigationItem.title = "Выбрать " + "Статус"
        case "Жанр":
            filterSet = filterDictionary?.first{$0.key == dataSource?.filtersModel?.genres.first?.key}
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.genres, filterSet: filterSet)
            controller.navigationItem.title = "Выбрать " + "Жанр"
        case "Год выхода":
            filterSet = filterDictionary?.first{$0.key == dataSource?.filtersModel?.years.first?.key}
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.years, filterSet: filterSet)
            controller.navigationItem.title = "Выбрать " + "Год выхода"
        case "Канал":
            filterSet = filterDictionary?.first{$0.key == dataSource?.filtersModel?.channels.first?.key}
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.channels, filterSet: filterSet)
            controller.navigationItem.title = "Выбрать " + "Канал"
        case "Тип":
            filterSet = filterDictionary?.first{$0.key == dataSource?.filtersModel?.groups.first?.key}
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.groups, filterSet: filterSet)
            controller.navigationItem.title = "Выбрать " + "Тип"
        default: return
        }
        
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilteringTVCCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = sectionCells[indexPath.section][indexPath.row]
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableView.headerView(forSection: section)?.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionCells[section].count
    }
}
