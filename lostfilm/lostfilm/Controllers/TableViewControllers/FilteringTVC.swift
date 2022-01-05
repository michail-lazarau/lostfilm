import UIKit

class FilteringTVC: UITableViewController, FilteringDataControllerDelegate {
    private let sections: [String] = ["Сортировка", "Фильтр"]
    private let sectionCells: [[String]] = [["Сортировать"], ["Статус", "Жанр", "Год выхода", "Канал", "Тип"]]
    internal var dataSource: FilteringDataController?
    
    init(style: UITableView.Style, dataController: FilteringDataController) {
        super.init(style: style)
        dataSource = dataController
        dataSource!.delegate = self
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
    
    func callMe() {
//        <#code#>
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let baseFilters = dataSource?.filtersModel
        else { return }
        let controller: BaseFilterTVC
        
        switch sectionCells[indexPath.section][indexPath.row] {
//        case "Сортировать": controller = BaseFilterTVC(style: .plain, dataController: dataSource?.filtersModel.)
        case "Статус": controller = BaseFilterTVC(style: .plain, dataController: baseFilters.types)
            controller.navigationItem.title = "Выбрать " + "Статус"
        case "Жанр": controller = BaseFilterTVC(style: .plain, dataController: baseFilters.genres)
            controller.navigationItem.title = "Выбрать " + "Жанр"
        case "Год выхода": controller = BaseFilterTVC(style: .plain, dataController: baseFilters.years)
            controller.navigationItem.title = "Выбрать " + "Год выхода"
        case "Канал": controller = BaseFilterTVC(style: .plain, dataController: baseFilters.channels)
            controller.navigationItem.title = "Выбрать " + "Канал"
        case "Тип": controller = BaseFilterTVC(style: .plain, dataController: baseFilters.groups)
            controller.navigationItem.title = "Выбрать " + "Тип"
        default: return
        }
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
