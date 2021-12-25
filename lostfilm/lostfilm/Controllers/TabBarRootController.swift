import UIKit

class TabBarRootController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        
        let tvSeriesVC = TVSeriesTableViewController(style: .plain, dataController: TVSeriesDataController())
        let tvSeriesNC = UINavigationController(rootViewController: tvSeriesVC)
        tvSeriesNC.navigationBar.prefersLargeTitles = true
        let newsVC = NewsTableViewController(style: .plain, dataController: NewsDataController())
        let newsNC = UINavigationController(rootViewController: newsVC)
        newsNC.navigationBar.prefersLargeTitles = true
        let videosVC = VideosTableViewController(style: .plain, dataController: VideosDataController())
        let videosNC = UINavigationController(rootViewController: videosVC)
        videosNC.navigationBar.prefersLargeTitles = true
        let newEpisodesVC = NewEpisodesTableViewController(style: .plain, dataController: NewEpisodesDataController())
        let newEpisodesNC = UINavigationController(rootViewController: newEpisodesVC);
        newEpisodesNC.navigationBar.prefersLargeTitles = true
        let scheduleVC = ScheduleTableViewController(style: .grouped, dataController: ScheduleDataController())
        let scheduleNC = UINavigationController(rootViewController: scheduleVC);
        scheduleNC.navigationBar.prefersLargeTitles = true
        
        tvSeriesVC.tabBarItem = UITabBarItem(title: "TV Series", image: UIImage(named: "icon_series_list"), tag: 0)
        newsVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: "icon_news"), tag: 1)
        videosVC.tabBarItem = UITabBarItem(title: "Videos", image:  UIImage(named: "icon_videos"), tag: 2)
        newEpisodesVC.tabBarItem = UITabBarItem(title: "New Episodes", image: UIImage(named: "icon_novelties"), tag: 3)
        scheduleVC.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "icon_timetable"), tag: 4)
        
        viewControllers = [tvSeriesNC, newsNC, videosNC, newEpisodesNC, scheduleNC]
    }
}
