import UIKit

class TVSeriesTVC: TemplateTVC<SeriesViewCell, LFSeriesModel> {
    override internal var tableCellHeight: CGFloat {
        return 175
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TV Series"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_filter"), style: .plain, target: self, action: #selector(DidShowFilters))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            navigationController?.pushViewController(LFSeriesDetailsVC(model: dataSource[indexPath.row]), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc private func DidShowFilters() {
        let filteringTVC = FilteringTVC(style: .grouped, DCwithSavedFilters: dataSource as! TVSeriesDataController)
        let navController = FilteringNavigationController(rootViewController: filteringTVC)
        filteringTVC.filteringDelegate = (dataSource as! FilteringDelegate)
        present(navController, animated: true)
    }
}
// MARK: how to display a VC
//    addChild(filteringTVC)
//    self.view.addSubview(filteringTVC.view)
//    filteringTVC.didMove(toParent: self)

//    navVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    navigationController?.pushViewController(FilteringTVC(), animated: true)

//    show(FilteringTVC(), sender: navigationItem.rightBarButtonItem)
