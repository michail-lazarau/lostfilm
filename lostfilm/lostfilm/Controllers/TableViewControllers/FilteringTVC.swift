import UIKit

class FilteringTVC: UITableViewController, FilteringDataControllerDelegate, BaseFilterDelegate {
    typealias FilterEnum = LFSeriesFilterModelPropertyEnum
    private let sections: [String] = [NSLocalizedString("Sorting", comment: ""), NSLocalizedString("Filtering", comment: "")]
    private let sectionCells: [[FilterEnum]] = [[FilterEnum.Sort], [FilterEnum.CustomType, FilterEnum.Genre, FilterEnum.ReleaseYear, FilterEnum.Channel, FilterEnum.Groups]]
    internal var dataSource: FilteringDataController?
    internal var filterDictionary: [LFSeriesFilterBaseModel]?
    internal var filteringDelegate: FilteringDelegate?

    init(style: UITableView.Style, dataController: FilteringDataController, filterDictionary: [LFSeriesFilterBaseModel]?) {
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
        navigationItem.title = "\(NSLocalizedString("Sorting", comment: "")) \(NSLocalizedString("and", comment: "")) \(NSLocalizedString("filtering", comment: ""))"
        dataSource?.getFilters()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        filteringDelegate?.sendFiltersToTVSeriesTVC(filters: filterDictionary)
    }

    @objc func DidViewControllerDismiss() {
        dismiss(animated: true, completion: nil)
    }

    func sendFiltersToFilteringTVC(filters: [LFSeriesFilterBaseModel]?) {
        if let filters = filters {
            if filterDictionary == nil {
                filterDictionary = []
            } else {
                filterDictionary?.removeAll { $0.key == filters[0].key }
            }
            filterDictionary?.append(contentsOf: filters)
        }
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
        let appliedFilters: [LFSeriesFilterBaseModel]?

        switch sectionCells[indexPath.section][indexPath.row] {
//        case "Сортировать": controller = BaseFilterTVC(style: .plain, dataController: dataSource?.filtersModel.)
        case .CustomType:
            appliedFilters = filterDictionary?.filter { $0.key == baseFilters.types.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.types, appliedFilters: appliedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.CustomType.localizedString())"
        case .Genre:
            appliedFilters = filterDictionary?.filter { $0.key == baseFilters.genres.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.genres, appliedFilters: appliedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Genre.localizedString())"
        case .ReleaseYear:
            appliedFilters = filterDictionary?.filter { $0.key == baseFilters.years.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.years, appliedFilters: appliedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.ReleaseYear.localizedString())"
        case .Channel:
            appliedFilters = filterDictionary?.filter { $0.key == baseFilters.channels.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.channels, appliedFilters: appliedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Channel.localizedString())"
        case .Groups:
            appliedFilters = filterDictionary?.filter { $0.key == baseFilters.groups.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.groups, appliedFilters: appliedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Groups.localizedString())"
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
