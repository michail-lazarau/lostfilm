import UIKit

class GlobalSearchTVC: UITableViewController, IUpdatingViewDelegate, UISearchBarDelegate {
    private var viewModel: GlobalSearchVM
    private weak var tabbarRootController = UIApplication.shared.windows.first?.rootViewController as? TabBarRootController
    private let searchController = UISearchController(searchResultsController: nil)
    private var lastSearchText: String?
    private var refreshTimer: Timer?
//    private let spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .gray)
//        spinner.hidesWhenStopped = true
//        return spinner
//    }()

    init(style: UITableView.Style, viewModel: GlobalSearchVM) {
        self.viewModel = viewModel
        super.init(style: style)
        self.viewModel.dataProvider.delegate = self
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = viewModel
        setupSearchController()
        registerCells()
    }

    func updateView() {
        viewModel.populateWithData()
//        spinner.stopAnimating()
        tableView.reloadData()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabbarRootController?.tabBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabbarRootController?.tabBar.isHidden = false
        searchController.searchBar.resignFirstResponder()
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchItem = viewModel.itemsForSections[indexPath.section]
        switch searchItem.type {
        case .series:
            let seriesDetailsVC = LFSeriesDetailsVC(model: (searchItem as! GlobalSearchSeriesItem)[indexPath.row])
            seriesDetailsVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(seriesDetailsVC, animated: true)
        default: break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // TODO: think of replacing literal height with dinamic by changing constraints
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.itemsForSections[indexPath.section]
        switch item.type {
        case .persons:
            return 66
        case .series:
            return 168
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GlobalSearchHeaderView.reuseIdentifier) as? GlobalSearchHeaderView
        header?.paragraphView.label.text = viewModel.itemsForSections[section].sectionTitle
        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension GlobalSearchTVC: UISearchResultsUpdating {
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }

    func updateSearchResults(for searchController: UISearchController) {
        // Add validation
        refreshTimer?.invalidate()
        refreshTimer = WeakTimer.scheduledTimer(timeInterval: 0.25, target: self, userInfo: nil, repeats: false) { [weak self] _ in
            guard let strongSelf = self else { return }

            let searchText = searchController.searchBar.text
            guard searchText?.count ?? 0 > 1 else {
                strongSelf.lastSearchText = nil
                strongSelf.viewModel.dataProvider.didEmptySearchResults()
                strongSelf.tableView.reloadData()
                return
            }

            guard strongSelf.lastSearchText != searchText else {
                return
            }
//            if !strongSelf.spinner.isAnimating {
//                strongSelf.spinner.startAnimating()
//            }
            strongSelf.lastSearchText = searchText

            strongSelf.viewModel.dataProvider.getGlobalSearchOutputFor(searchContext: strongSelf.lastSearchText!) // MARK: lastSearchText is never nil by this step

//            strongSelf.spinner.stopAnimating()
            strongSelf.refreshTimer = nil
        }
    }
}

// https://stackoverflow.com/questions/27951965/cannot-set-searchbar-as-firstresponder
extension GlobalSearchTVC: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - Setup

extension GlobalSearchTVC {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.searchController?.delegate = self
        definesPresentationContext = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.hidesBackButton = true
        (searchController.searchBar.value(forKey: "cancelButton") as? UIButton)?.addTarget(self, action: #selector(searchBarCancelButtonClicked), for: .touchUpInside)
    }

    private func registerCells() {
        tableView.register(SeriesViewCell.self, forCellReuseIdentifier: SeriesViewCell.reuseIdentifier)
        tableView.register(SeriesCastViewCell.nib, forCellReuseIdentifier: SeriesCastViewCell.reuseIdentifier)
        tableView.register(GlobalSearchHeaderView.nib, forHeaderFooterViewReuseIdentifier: GlobalSearchHeaderView.reuseIdentifier)
    }

    @objc internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
}
