import UIKit

class GlobalSearchTVC: UITableViewController, DelegateGlobalSearchDC {
    var viewModel: GlobalSearchVM
    private let searchController = UISearchController(searchResultsController: nil)
    
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
    
    func updateTableView(by searchContext: String) {
//        viewModel.dataProvider.getGlobalSearchOutputFor(searchContext: searchContext)
//        viewModel.fetchDataItems()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GlobalSearchTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
    }
}

// MARK: - Setup

extension GlobalSearchTVC {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

    private func registerCells() {
        tableView.register(SeriesViewCell.self, forCellReuseIdentifier: SeriesViewCell.reuseIdentifier)
        tableView.register(SeriesCastViewCell.nib, forCellReuseIdentifier: SeriesCastViewCell.reuseIdentifier)
    }
}
