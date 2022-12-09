import Foundation

protocol TabRoute {
    func makeTab(for tab: Tabs, router: DefaultRouter, rightBarButtonItems: [UIBarButtonItem]) -> UINavigationController
//    func makeTab(for tab: Tabs, router: DefaultRouter) -> UINavigationController
}

extension TabRoute where Self: Router {
    private func makeViewController(for tab: Tabs, router: DefaultRouter) -> UIViewController {
        let viewController: UIViewController
        switch tab {
        case .series:
            viewController = TVSeriesTVC(style: .plain, dataController: TVSeriesDataController(router: router))
        case .news:
            viewController = NewsTVC(style: .plain, dataController: NewsDataController(router: router))
        case .videos:
            viewController = VideosTVC(style: .plain, dataController: VideosDataController(router: router))
        case .newEpisodes:
            viewController = NewEpisodesTVC(style: .plain, dataController: NewEpisodesDataController(router: router))
        case .schedule:
            viewController = ScheduleTVC(style: .grouped, dataController: ScheduleDataController(router: router))
        }
        router.root = viewController
        return viewController
    }

    func makeTab(for tab: Tabs, router: DefaultRouter, rightBarButtonItems: [UIBarButtonItem]) -> UINavigationController {
        let viewController = makeViewController(for: tab, router: router)
        viewController.navigationItem.rightBarButtonItems = rightBarButtonItems
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = tab.item
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }

//    func makeTab(for tab: Tabs, router: DefaultRouter) -> UINavigationController {
//        let viewController = makeViewController(for: tab, router: router)
//        let navController = UINavigationController(rootViewController: viewController)
//        navController.tabBarItem = tab.item
//        navController.navigationBar.prefersLargeTitles = true
//        return navController
//    }
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

// FIXME: DELETE later
//    func makeTab<Cell: CellConfigurable, Model: LFJsonObject>(router: DefaultRouter, controller: (DefaultRouter) -> TemplateTVC<Cell, Model>) -> UIViewController {
//        let vc = controller(router)
//        router.root = vc
//        return vc
//    }
