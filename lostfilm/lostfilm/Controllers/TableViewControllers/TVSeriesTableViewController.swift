import UIKit

class TVSeriesTableViewController: TemplateTableViewController<SeriesViewCell, LFSeriesModel>, BaseFilterDelegate {
    
    func sendFiltersToTVSeriesTVC(filters: (key: String, values: Set<String>)) {
//        filterDictionary?.merge(<#T##other: [String : Set<String>]##[String : Set<String>]#>, uniquingKeysWith: <#T##(Set<String>, Set<String>) throws -> Set<String>#>)
    }
    
    
    internal var filterDictionary: [String : Set<String>]?
    override internal var tableCellHeight: CGFloat {
        return 175
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TV Series"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_filter"), style: .plain, target: self, action: #selector(DidShowFilters))
    }
    
    @objc private func DidShowFilters() {
        let filteringTVC = FilteringTVC(style: .grouped, dataController: FilteringDataController())
        let navController = UINavigationController(rootViewController: filteringTVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
        
//                addChild(filteringTVC)
        //        self.view.addSubview(filteringTVC.view)
        //        filteringTVC.didMove(toParent: self)
        
        //    navVC.modalPresentationStyle = UIModalPresentationFullScreen;
//        navigationController?.pushViewController(FilteringTVC(), animated: true)
        
        //        show(FilteringTVC(), sender: navigationItem.rightBarButtonItem)
    }
}
