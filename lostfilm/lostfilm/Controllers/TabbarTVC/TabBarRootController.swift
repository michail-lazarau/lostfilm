import UIKit

class TabBarRootController: UITabBarController, ProfileButtonDelegate {
    typealias Routes = LoginRoute & TabRoute
    private let router: Routes
    private let userSessionInfo: UserSessionService

    init(router: Routes, userSessionInfo: UserSessionService) {
        self.router = router
        self.userSessionInfo = userSessionInfo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        router = DefaultRouter(rootTransition: EmptyTransition())
        userSessionInfo = UserSessionInfo()
        super.init(coder: coder)
    }

    lazy var profileButton: UIBarButtonItem = {
        if let username = userSessionInfo.username, userSessionInfo.authorised() {
            return UIBarButtonItem(customView: ProfileButton(title: username, titleColor: UIColor.white, backgroundColor: UIColor(named: "button")))
        }
        return UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: #selector(openLogin))
    }()

    func resetProfileButton(username: String) {
        userSessionInfo.willSaveToUserDefaults(key: .username, value: username)
        let title = username.split { $0 == " " }.reduce(into: String()) { partialResult, substring in
            partialResult.append(substring.first?.uppercased() ?? "?")
        }
        profileButton = UIBarButtonItem(customView: ProfileButton(title: title, titleColor: UIColor.white, backgroundColor: UIColor(named: "button")))
        // FIXME: dirty but it does the job
        viewControllers?.forEach({ navController in
            navController.children.first?.navigationItem.rightBarButtonItem = profileButton
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        profileButton.target = self

        viewControllers = [
            router.makeTab(for: .series, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton]),
            router.makeTab(for: .news, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton]),
            router.makeTab(for: .videos, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton]),
            router.makeTab(for: .newEpisodes, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton]),
            router.makeTab(for: .schedule, router: DefaultRouter(rootTransition: EmptyTransition()), rightBarButtonItems: [profileButton])]
    }

    @objc func openLogin() {
        router.openLogin()
    }
}
