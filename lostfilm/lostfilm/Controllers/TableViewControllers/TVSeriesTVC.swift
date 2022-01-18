import UIKit

class TVSeriesTVC: TemplateTVC<SeriesViewCell, LFSeriesModel>, FilteringDelegate {
    
    internal var filterDictionary: [LFSeriesFilterBaseModel]?
    override internal var tableCellHeight: CGFloat {
        return 175
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TV Series"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_filter"), style: .plain, target: self, action: #selector(DidShowFilters))
    }
    
    func sendFiltersToTVSeriesTVC(filters: [LFSeriesFilterBaseModel]) {
        filterDictionary = filters
        
    }
    
    @objc private func DidShowFilters() {
        let filteringTVC = FilteringTVC(style: .grouped, dataController: FilteringDataController(), appliedFilters: filterDictionary)
        
        let navController = UINavigationController(rootViewController: filteringTVC)
        navController.modalPresentationStyle = .fullScreen
        filteringTVC.filteringDelegate = self
        present(navController, animated: true)
        
//                addChild(filteringTVC)
        //        self.view.addSubview(filteringTVC.view)
        //        filteringTVC.didMove(toParent: self)
        
        //    navVC.modalPresentationStyle = UIModalPresentationFullScreen;
//        navigationController?.pushViewController(FilteringTVC(), animated: true)
        
        //        show(FilteringTVC(), sender: navigationItem.rightBarButtonItem)
    }
    
    
}
