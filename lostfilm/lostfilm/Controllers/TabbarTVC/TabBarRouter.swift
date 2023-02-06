//
//  TabBarRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

@objc protocol TabModuleInput: AnyObject {
    func showSignedInUserProfileButton(with userInitials: String)
    func showSignedOutUserProfileButton()
}

final class TabBarRouter: DefaultRouter {
    private let userSessionData: UserSessionService
    private var tabs: [WeakBox<TabModuleInput>] = []

    init(userSessionData: UserSessionService) {
        self.userSessionData = userSessionData
        super.init(rootTransition: EmptyTransition())
    }

    override func start() -> UIViewController {
        let tabBarController = UITabBarController()
        let tabs = [
            makeViewController(for: .series),
            makeViewController(for: .news),
            makeViewController(for: .videos),
            makeViewController(for: .newEpisodes),
            makeViewController(for: .schedule)
        ]
        tabBarController.viewControllers = tabs.compactMap { $0.0 }
        self.tabs = tabs.compactMap { $0.1 }.compactMap { WeakBox($0) }
        root = tabBarController
        refreshProfileButton()
        return tabBarController
    }

    override func shouldCompleteRouter(_ router: DefaultRouter) {
        if router is LoginRouter {
            refreshProfileButton()
            root?.dismiss(animated: true)
        } else {
            super.shouldCompleteRouter(router)
        }
    }

    private func refreshProfileButton() {
        let tabs = tabs.compactMap { $0.value }
        if userSessionData.isAuthorised {
            tabs.forEach { $0.showSignedInUserProfileButton(with: userSessionData.userInitials) }
        } else {
            tabs.forEach { $0.showSignedOutUserProfileButton() }
        }
    }
}

// MARK: - LoginRoute

extension TabBarRouter: LoginRoute {

    func openLogin() {
        let transition = ModalTransition()
        let router = LoginRouter(userSessionData: UserSessionStoredData(), rootTransition: transition, registrationPresenterDelegate: self)
        route(to: router, using: transition)
    }
}

extension TabBarRouter: RegistrationPresenterProtocol {
    func showRegistration() {
        let transition = ModalTransition()
        let router = RegistrationRouter(rootTransition: transition)
        route(to: router, using: transition)
    }
}

// MARK: - Private helpers

private extension TabBarRouter {

    func makeViewController(for tab: Tabs) -> (UIViewController, TabModuleInput?) {
        let router: TemplateRouter
        switch tab {
        case .series:
            router = TVSeriesRouter(loginRoute: self, rootTransition: EmptyTransition())
        case .news:
            router = NewsRouter(loginRoute: self, rootTransition: EmptyTransition())
        case .videos:
            router = VideosRouter(loginRoute: self, rootTransition: EmptyTransition())
        case .newEpisodes:
            router = NewEpisodesRouter(loginRoute: self, rootTransition: EmptyTransition())
        case .schedule:
            router = ScheduleRouter(loginRoute: self, rootTransition: EmptyTransition())
        }
        let viewController = router.start()
        viewController.tabBarItem = tab.item
        return (viewController, router.dataController)
    }
}

private enum Tabs: Int {
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
