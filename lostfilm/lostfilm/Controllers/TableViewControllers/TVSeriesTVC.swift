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
//        if let dataSource = dataSource {
//            if !(dataSource as! TVSeriesDataController).savedFilters.isEmpty {
//                dataSource.DidEmptyItemList()
//                dataSource.LoadingData()
//            }
//        }
        if !(dataSource as! TVSeriesDataController).savedFilters.isEmpty {
            dataSource?.DidEmptyItemList()
            dataSource?.LoadingData()
        }
    }
    
    @objc private func DidShowFilters() {
        let filteringTVC = FilteringTVC(style: .grouped, dataController: FilteringDataController(), appliedFilters: (dataSource as! TVSeriesDataController).savedFilters)
        
        let navController = UINavigationController(rootViewController: filteringTVC)
        navController.modalPresentationStyle = .fullScreen
        filteringTVC.filteringDelegate = (dataSource as! FilteringDelegate)
        present(navController, animated: true)
        
//                addChild(filteringTVC)
        //        self.view.addSubview(filteringTVC.view)
        //        filteringTVC.didMove(toParent: self)
        
        //    navVC.modalPresentationStyle = UIModalPresentationFullScreen;
//        navigationController?.pushViewController(FilteringTVC(), animated: true)
        
        //        show(FilteringTVC(), sender: navigationItem.rightBarButtonItem)
    }
    
    
}
