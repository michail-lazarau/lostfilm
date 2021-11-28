import UIKit

class TabBarRootController: UITabBarController {

    private var dataSource: DataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        
        let tvSeriesVC = SeriesTableViewController(style: .plain, dataController: dataSource)
        let newsVC = NewsController()
        
        tvSeriesVC.tabBarItem = UITabBarItem(title: "TV Series", image: UIImage(named: "icon_series_list"), tag: 0)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "icon_news"), tag: 1)
        viewControllers = [UINavigationController(rootViewController: tvSeriesVC), newsVC]
    }
}
