import UIKit

class TabBarRootController: UITabBarController {

//    private var dataSource: TVSeriesDataController = TVSeriesDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        
        let tvSeriesVC = TVSeriesTableViewController(style: .plain, dataController: TVSeriesDataController())
        let newsVC = NewsController()
        
        tvSeriesVC.tabBarItem = UITabBarItem(title: "TV Series", image: UIImage(named: "icon_series_list"), tag: 0)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "icon_news"), tag: 1)

        let navigationController = UINavigationController(rootViewController: tvSeriesVC)
        navigationController.navigationBar.prefersLargeTitles = true
        viewControllers = [navigationController, newsVC]
        
    }
}
