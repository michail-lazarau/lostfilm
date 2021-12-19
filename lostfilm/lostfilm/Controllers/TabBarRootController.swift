import UIKit

class TabBarRootController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        
        let tvSeriesVC = TVSeriesTableViewController(style: .plain, dataController: TVSeriesDataController())
        let newsVC = NewsTableViewController(style: .plain, dataController: NewsDataController())
        let videosVC = VideosTableViewController(style: .plain, dataController: VideosDataController())
        
        tvSeriesVC.tabBarItem = UITabBarItem(title: "TV Series", image: UIImage(named: "icon_series_list"), tag: 0)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "icon_news"), tag: 1)
        videosVC.tabBarItem = UITabBarItem(title: "Videos", image:  UIImage(named: "icon_videos"), tag: 2)

        let navigationController = UINavigationController(rootViewController: tvSeriesVC)
        navigationController.navigationBar.prefersLargeTitles = true
        viewControllers = [navigationController, newsVC, videosVC]
    }
}
