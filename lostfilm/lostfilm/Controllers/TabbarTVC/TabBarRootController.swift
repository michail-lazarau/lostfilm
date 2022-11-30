import UIKit

class TabBarRootController: UITabBarController, UserProfileDelegate {

    let profileButton: UIBarButtonItem = {
        if let username = UserSessionService.username, UserSessionService.authorised() {
            return UIBarButtonItem(customView: ProfileButton(title: username, titleColor: UIColor.white, backgroundColor: UIColor(named: "button")))
        }
        return UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: nil)
    }()

    func drawProfileButton(username: String) {
        let title = username.split { $0 == " " }.reduce(into: String()) { partialResult, substring in
            partialResult.append(substring.first?.uppercased() ?? "?")
        }
        profileButton.customView = ProfileButton(title: title, titleColor: UIColor.white, backgroundColor: UIColor(named: "button"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white

        let seriesVC = TVSeriesTVC(style: .plain, dataController: TVSeriesDataController(router: DefaultRouter(rootTransition: EmptyTransition())))
        let newsVC = NewsTVC(style: .plain, dataController: NewsDataController(router: DefaultRouter(rootTransition: EmptyTransition())))
        let videosVC = VideosTVC(style: .plain, dataController: VideosDataController(router: DefaultRouter(rootTransition: EmptyTransition())))
        let newEpisodesVC = NewEpisodesTVC(style: .plain, dataController: NewEpisodesDataController(router: DefaultRouter(rootTransition: EmptyTransition())))
        let scheduleVC = ScheduleTVC(style: .grouped, dataController: ScheduleDataController(router: DefaultRouter(rootTransition: EmptyTransition())))

        viewControllers = [makeTab(tab: Tabs.series.item, viewController: seriesVC),
                           makeTab(tab: Tabs.news.item, viewController: newsVC),
                           makeTab(tab: Tabs.videos.item, viewController: videosVC),
                           makeTab(tab: Tabs.newEpisodes.item, viewController: newEpisodesVC),
                           makeTab(tab: Tabs.schedule.item, viewController: scheduleVC)]
    }

    private func makeTab(tab: UITabBarItem, viewController: TemplateTVC<some CellConfigurable, some LFJsonObject>) -> UIViewController {
        (viewController.dataSource?.router as? Router)?.root = viewController
        viewController.navigationItem.rightBarButtonItems = [profileButton]
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = tab
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }

    private func makeTab(tab: UITabBarItem, viewController: ScheduleTVC) -> UIViewController {
        (viewController.dataSource?.router as? Router)?.root = viewController
        viewController.navigationItem.rightBarButtonItems = [profileButton]
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = tab
        navController.navigationBar.prefersLargeTitles = true
        return navController
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
