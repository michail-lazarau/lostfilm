import UIKit

class TabBarRootController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        
        let tvSeriesVC = TVSeriesController()
        let newsVC = NewsController()
        
        tvSeriesVC.tabBarItem = UITabBarItem(title: "TV Series", image: UIImage(named: "icon_series_list"), tag: 0)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "icon_news"), tag: 1)
        viewControllers = [UINavigationController(rootViewController: tvSeriesVC), newsVC]
    }
}
