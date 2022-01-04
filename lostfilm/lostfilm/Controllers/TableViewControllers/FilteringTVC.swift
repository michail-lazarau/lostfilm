import UIKit

class FilteringTVC: UITableViewController /*, FilteringDataControllerDelegate */{
//    func callMe() {
////        <#code#>
//    }
    
    private let sections: [String] = ["Сортировка", "Фильтр"]
    private let sectionCells: [[String]] = [["Сортировать"], ["Статус", "Жанр", "Год выхода", "Канал", "Тип"]]
//    internal var dataSource: FilteringDataController?
    
//    init(style: UITableView.Style, dataController: FilteringDataController) {
//        super.init(style: style)
//        dataSource = dataController
//        dataSource!.delegate = self
//
//        // MARK: delete code below it later
////        dataSourceOfFiltering.getFilters()
//    }

//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        dataSource = nil
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilteringTVCCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "xmark"), style: .plain, target: self, action: #selector(DidViewControllerDismiss))
        navigationItem.title = "Сортировка и фильтр"
    }
    
    @objc func DidViewControllerDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
