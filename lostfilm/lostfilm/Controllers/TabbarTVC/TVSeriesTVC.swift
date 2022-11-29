import UIKit

class TVSeriesTVC: TemplateTVC<SeriesViewCell, LFSeriesModel>, UserProfileDelegate {
    private let customNavigationControllerDelegate = CustomNavigationControllerDelegate()
    private lazy var profileButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(DidShowLoginPage))
    }()

    override internal var tableCellHeight: CGFloat {
        return 175
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TV Series"
        navigationItem.rightBarButtonItems = [
            profileButton,
            UIBarButtonItem(image: UIImage(named: "icon_filter"), style: .plain, target: self, action: #selector(DidShowFilters))
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "magnifying_glass"), style: .plain, target: self, action: #selector(DidShowGlobalSearch))
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            navigationController?.delegate = customNavigationControllerDelegate
            navigationController?.pushViewController(LFSeriesDetailsVC(model: dataSource[indexPath.row]), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func updateProfileButton(username: String) {
        // проверка на токен
        profileButton.image = nil
        profileButton.title = username.split { $0 == " " }.reduce(into: String()) { partialResult, substring in
            return partialResult.append(substring.first?.uppercased() ?? "?")
        }
        (profileButton.value(forKey: "view") as? UIView)?.backgroundColor = UIColor(named: "button")
    }

    @objc private func DidShowFilters() {
        guard let dataSource = dataSource as? TVSeriesDataController & FilteringDelegate else {
            return
        }

        let filteringTVC = FilteringTVC(style: .grouped, DCwithSavedFilters: dataSource)
        let navController = FilteringNavigationController(rootViewController: filteringTVC)
        filteringTVC.filteringDelegate = dataSource
        present(navController, animated: true)
    }

    @objc private func DidShowLoginPage() {
        (dataSource as? TVSeriesDataController)?.openLogin()
        
//        ((dataSource as? TVSeriesDataController)?.router as? DefaultRouter)?.root
    }

    @objc private func DidShowGlobalSearch() {
        let globalSearchTVC = GlobalSearchTVC(style: .grouped, viewModel: GlobalSearchVM(dataProvider: GlobalSearchDC()))
        if let presentedVC = presentedViewController {
            presentedVC.dismiss(animated: false, completion: nil)
        }

        navigationController?.setViewControllers([self, globalSearchTVC], animated: true)
    }
}

// MARK: how to display a VC

//    addChild(filteringTVC)
//    self.view.addSubview(filteringTVC.view)
//    filteringTVC.didMove(toParent: self)

//    navVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    navigationController?.pushViewController(FilteringTVC(), animated: true)

//    show(FilteringTVC(), sender: navigationItem.rightBarButtonItem)
