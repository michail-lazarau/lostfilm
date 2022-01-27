import UIKit

class FilteringTVC: UITableViewController {
    typealias FilterEnum = LFSeriesFilterModelPropertyEnum
    private let sections: [String] = [NSLocalizedString("Sorting", comment: ""), NSLocalizedString("Filtering", comment: "")]
    private let sectionCells: [[FilterEnum]] = [[FilterEnum.Sort], [FilterEnum.CustomType, FilterEnum.Genre, FilterEnum.ReleaseYear, FilterEnum.Channel, FilterEnum.Group]]
    internal var dataSource: FilteringDataController = FilteringDataController()
    internal var DCwithSavedFilters: TVSeriesDataController? // make weak?
    internal var filteringDelegate: FilteringDelegate?

    init(style: UITableView.Style, DCwithSavedFilters: TVSeriesDataController) {
        self.DCwithSavedFilters = DCwithSavedFilters
        super.init(style: style)
    }

    required init?(coder: NSCoder) {
        DCwithSavedFilters = nil
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilteringTVCCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "xmark"), style: .plain, target: self, action: #selector(DidViewControllerDismiss))
        navigationItem.title = "\(NSLocalizedString("Sorting", comment: "")) \(NSLocalizedString("and", comment: "")) \(NSLocalizedString("filtering", comment: ""))"
        dataSource.getFilters()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if navigationController?.viewControllers.count == 1 { // MARK: LOL
            DCwithSavedFilters?.DidEmptyItemList()
            DCwithSavedFilters?.LoadingData()
        }
    }

    @objc func DidViewControllerDismiss() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let DCwithSavedFilters = DCwithSavedFilters else {
            return
        }
        guard let baseFilters = dataSource.filtersModel else {
            return
        }
        let choose = NSLocalizedString("Choose", comment: "")
        let controller: BaseFilterTVC

        switch sectionCells[indexPath.section][indexPath.row] {
//        case "Сортировать": controller = BaseFilterTVC(style: .plain, dataController: dataSource?.filtersModel.)
        case .CustomType:
            controller = BaseFilterTVC(style: .plain, filtersToDisplay: baseFilters.types, DCwithSelectedFilters: DCwithSavedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.CustomType.localizedString())"
        case .Genre:
            controller = BaseFilterTVC(style: .plain, filtersToDisplay: baseFilters.genres, DCwithSelectedFilters: DCwithSavedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Genre.localizedString())"
        case .ReleaseYear:
            controller = BaseFilterTVC(style: .plain, filtersToDisplay: baseFilters.years, DCwithSelectedFilters: DCwithSavedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.ReleaseYear.localizedString())"
        case .Channel:
            controller = BaseFilterTVC(style: .plain, filtersToDisplay: baseFilters.channels, DCwithSelectedFilters: DCwithSavedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Channel.localizedString())"
        case .Group:
            controller = BaseFilterTVC(style: .plain, filtersToDisplay: baseFilters.groups, DCwithSelectedFilters: DCwithSavedFilters)
            controller.navigationItem.title = "\(choose) \(FilterEnum.Group.localizedString())"
        default: return
        }

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
