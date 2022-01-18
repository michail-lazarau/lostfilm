import UIKit

class FilteringTVC: UITableViewController, FilteringDataControllerDelegate, BaseFilterDelegate {
    typealias FilterEnum = LFSeriesFilterModelPropertyEnum
    private let sections: [String] = [NSLocalizedString("Sorting", comment: ""), NSLocalizedString("Filtering", comment: "")]
    private let sectionCells: [[FilterEnum]] = [[FilterEnum.Sort], [FilterEnum.CustomType, FilterEnum.Genre, FilterEnum.ReleaseYear, FilterEnum.Channel, FilterEnum.Group]]
    internal var dataSource: FilteringDataController?
    internal var appliedFilters: [LFSeriesFilterBaseModel]
    internal var filteringDelegate: FilteringDelegate?

    init(style: UITableView.Style, dataController: FilteringDataController, appliedFilters: [LFSeriesFilterBaseModel]?) {
        self.appliedFilters = appliedFilters ?? []
        super.init(style: style)
        dataSource = dataController
        dataSource!.delegate = self
    }

    required init?(coder: NSCoder) {
        appliedFilters = []
        super.init(coder: coder)
        dataSource = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilteringTVCCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "xmark"), style: .plain, target: self, action: #selector(DidViewControllerDismiss))
        navigationItem.title = "\(NSLocalizedString("Sorting", comment: "")) \(NSLocalizedString("and", comment: "")) \(NSLocalizedString("filtering", comment: ""))"
        dataSource?.getFilters()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        filteringDelegate?.sendFiltersToTVSeriesDC(filters: appliedFilters)
    }

    @objc func DidViewControllerDismiss() {
        dismiss(animated: true, completion: nil)
    }

    func sendFiltersToFilteringTVC(filters: [LFSeriesFilterBaseModel]) {
        if !filters.isEmpty {
            appliedFilters.removeAll { $0.key == filters[0].key }
        }
            appliedFilters.append(contentsOf: filters)
    }

    func callMe() {
//        <#code#>
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let baseFilters = dataSource?.filtersModel else {
            return
        }
        let choose = NSLocalizedString("Choose", comment: "")
        let controller: BaseFilterTVC
        let selectedFilters: [LFSeriesFilterBaseModel]

        switch sectionCells[indexPath.section][indexPath.row] {
//        case "Сортировать": controller = BaseFilterTVC(style: .plain, dataController: dataSource?.filtersModel.)
        case .CustomType:
            selectedFilters = appliedFilters.filter { $0.key == baseFilters.types.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.types, selectedFilters: selectedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.CustomType.localizedString())"
        case .Genre:
            selectedFilters = appliedFilters.filter { $0.key == baseFilters.genres.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.genres, selectedFilters: selectedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Genre.localizedString())"
        case .ReleaseYear:
            selectedFilters = appliedFilters.filter { $0.key == baseFilters.years.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.years, selectedFilters: selectedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.ReleaseYear.localizedString())"
        case .Channel:
            selectedFilters = appliedFilters.filter { $0.key == baseFilters.channels.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.channels, selectedFilters: selectedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Channel.localizedString())"
        case .Group:
            selectedFilters = appliedFilters.filter { $0.key == baseFilters.groups.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.groups, selectedFilters: selectedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Group.localizedString())"
        default: return
        }

        controller.baseFilterDelegate = self
        navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilteringTVCCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = sectionCells[indexPath.section][indexPath.row].localizedString()
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
