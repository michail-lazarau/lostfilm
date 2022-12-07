import UIKit

class TabBarRootController: UITabBarController, RouterDelegate {
    typealias Routes = LoginRoute & TabRoute
    private let router: Routes
    private let userSessionData: UserSessionService
//    weak var routerDelegate: RouterDelegate?

    init(router: Routes, userSessionData: UserSessionService) {
        self.router = router
        self.userSessionData = userSessionData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var profileButton: UIBarButtonItem = {
//        if let username = userSessionData.username, userSessionData.isAuthorised() {
//            return UIBarButtonItem(customView: ProfileButton(title: username, titleColor: UIColor.white, backgroundColor: UIColor(named: "button")))
//        }
        return UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: #selector(openLogin))
    }()

    func routerDidComplete(_ router: DefaultRouter) {
        let title = userSessionData.username?.split { $0 == " " }.reduce(into: String()) { partialResult, substring in
            partialResult.append(substring.first?.uppercased() ?? "?")
        }
        viewControllers?.forEach({ navController in
            navController.children.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: ProfileButton(title: title, titleColor: UIColor.white, backgroundColor: UIColor(named: "button")))
        })
    }

//    func resetProfileButton() {
//        let title = userSessionData.username?.split { $0 == " " }.reduce(into: String()) { partialResult, substring in
//            partialResult.append(substring.first?.uppercased() ?? "?")
//        }
////        profileButton = UIBarButtonItem(customView: ProfileButton(title: title, titleColor: UIColor.white, backgroundColor: UIColor(named: "button")))
//        // FIXME: dirty but it does the job
//        viewControllers?.forEach({ navController in
//            navController.children.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: ProfileButton(title: title, titleColor: UIColor.white, backgroundColor: UIColor(named: "button")))
//        })
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
//        profileButton.target = self // comment to disable button

        viewControllers = [
            router.makeTab(for: .series, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton]),
            router.makeTab(for: .news, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton]),
            router.makeTab(for: .videos, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton]),
            router.makeTab(for: .newEpisodes, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton]),
            router.makeTab(for: .schedule, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton])]
//            router.makeTab(for: .series, router: DefaultRouter(rootTransition: EmptyTransition())),
//            router.makeTab(for: .news, router: DefaultRouter(rootTransition: EmptyTransition())),
//            router.makeTab(for: .videos, router: DefaultRouter(rootTransition: EmptyTransition())),
//            router.makeTab(for: .newEpisodes, router: DefaultRouter(rootTransition: EmptyTransition())),
//            router.makeTab(for: .schedule, router: DefaultRouter(rootTransition: EmptyTransition()))]
    }

    @objc func openLogin() {
        router.openLogin(userSessionData: userSessionData)
    }
}
