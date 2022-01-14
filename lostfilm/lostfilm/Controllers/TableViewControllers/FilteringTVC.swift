import UIKit

class FilteringTVC: UITableViewController, FilteringDataControllerDelegate, BaseFilterDelegate {
    typealias FilterEnum = LFSeriesFilterModelPropertyEnum
    private let sections: [String] = [NSLocalizedString("Sorting", comment: ""), NSLocalizedString("Filtering", comment: "")]
    private let sectionCells: [[FilterEnum]] = [[FilterEnum.Sort], [FilterEnum.CustomType, FilterEnum.Genre, FilterEnum.ReleaseYear, FilterEnum.Channel, FilterEnum.Groups]]
    internal var dataSource: FilteringDataController?
    internal var filterDictionary: [String: Set<String>]?
    internal var filteringDelegate: FilteringDelegate?

    init(style: UITableView.Style, dataController: FilteringDataController, filterDictionary: [String: Set<String>]?) {
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
        if let filterDictionary = filterDictionary {
            filteringDelegate?.sendFiltersToTVSeriesTVC(filters: filterDictionary)
        }
    }

    @objc func DidViewControllerDismiss() {
        dismiss(animated: true, completion: nil)
    }

    func sendFiltersToFilteringTVC(filters: (key: String, values: Set<String>)) {
        if filterDictionary == nil {
            filterDictionary = [:]
        }

        filterDictionary?.merge([filters.key: filters.values]) { _, new in new }
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
        let filterSet: (String, Set<String>)?

        switch sectionCells[indexPath.section][indexPath.row] {
//        case "Сортировать": controller = BaseFilterTVC(style: .plain, dataController: dataSource?.filtersModel.)
        case .CustomType:
            filterSet = filterDictionary?.first { $0.key == dataSource?.filtersModel?.types.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.types, filterSet: filterSet)
            controller.navigationItem.title = "\(choose) \(FilterEnum.CustomType.localizedString())"
        case .Genre:
            filterSet = filterDictionary?.first { $0.key == dataSource?.filtersModel?.genres.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.genres, filterSet: filterSet)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Genre.localizedString())"
        case .ReleaseYear:
            filterSet = filterDictionary?.first { $0.key == dataSource?.filtersModel?.years.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.years, filterSet: filterSet)
            controller.navigationItem.title = "\(choose) \(FilterEnum.ReleaseYear.localizedString())"
        case .Channel:
            filterSet = filterDictionary?.first { $0.key == dataSource?.filtersModel?.channels.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.channels, filterSet: filterSet)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Channel.localizedString())"
        case .Groups:
            filterSet = filterDictionary?.first { $0.key == dataSource?.filtersModel?.groups.first?.key }
            controller = BaseFilterTVC(style: .plain, dataController: baseFilters.groups, filterSet: filterSet)
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
