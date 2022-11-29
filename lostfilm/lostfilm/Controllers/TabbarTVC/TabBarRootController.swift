import UIKit

class TabBarRootController: UITabBarController {
//    typealias Routes = LoginRoute
//    private var router: Routes?
//
//    init(router: Routes) {
//        self.router = router
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white

        let newsVC = NewsTVC(style: .plain, dataController: NewsDataController())
        let newsNC = UINavigationController(rootViewController: newsVC)
        newsNC.navigationBar.prefersLargeTitles = true
        let videosVC = VideosTVC(style: .plain, dataController: VideosDataController())
        let videosNC = UINavigationController(rootViewController: videosVC)
        videosNC.navigationBar.prefersLargeTitles = true
        let newEpisodesVC = NewEpisodesTVC(style: .plain, dataController: NewEpisodesDataController())
        let newEpisodesNC = UINavigationController(rootViewController: newEpisodesVC)
        newEpisodesNC.navigationBar.prefersLargeTitles = true
        let scheduleVC = ScheduleTVC(style: .grouped, dataController: ScheduleDataController())
        let scheduleNC = UINavigationController(rootViewController: scheduleVC)
        scheduleNC.navigationBar.prefersLargeTitles = true

        newsVC.tabBarItem = Tabs.news.item
        videosVC.tabBarItem = Tabs.videos.item
        newEpisodesVC.tabBarItem = Tabs.newEpisodes.item
        scheduleVC.tabBarItem = Tabs.schedule.item

        viewControllers = [makeSeriesTab(), newsNC, videosNC, newEpisodesNC, scheduleNC]
    }

    private func makeSeriesTab() -> UIViewController {
        // No transitions since these are managed by the TabBarController
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let tvSeriesVC = TVSeriesTVC(style: .plain, dataController: TVSeriesDataController(router: router))
        router.root = tvSeriesVC

        return tvSeriesVC.makeTab(tab: Tabs.series.item)
    }

//    func openLogin() {
//        router?.openLogin()
//    }
}

fileprivate extension UIViewController {
    func makeTab(tab: UITabBarItem) -> UIViewController {
        let tvSeriesNC = UINavigationController(rootViewController: self)
        tvSeriesNC.tabBarItem = tab
        tvSeriesNC.navigationBar.prefersLargeTitles = true
        return tvSeriesNC
    }
}

enum Tabs: Int {
    case series = 0
    case news
    case videos
    case newEpisodes
    case schedule

    var item: UITabBarItem {
        let itemProps: (title: String, image: UIImage?)
        switch self {
        case .series:
            itemProps = (title: "TV Series", image: UIImage(named: "icon_series_list"))
        case .news:
            itemProps = (title: "News", image: UIImage(named: "icon_news"))
        case .videos:
            itemProps = (title: "Videos", image: UIImage(named: "icon_videos"))
        case .newEpisodes:
            itemProps = (title: "New Episodes", image: UIImage(named: "icon_novelties"))
        case .schedule:
            itemProps = (title: "Schedule", image: UIImage(named: "icon_timetable"))
        }

        return UITabBarItem(title: itemProps.title, image: itemProps.image, tag: rawValue)
    }
}
