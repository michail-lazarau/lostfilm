import Foundation

protocol LoginRoute {
    func openLogin(userSessionData: UserSessionService)
}

extension LoginRoute where Self: Router {
    func openLogin(with transition: Transition, userSessionData: UserSessionService) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = LoginViewModel(dataProvider: LoginService(session: URLSession.shared), router: router, userSessionData: userSessionData)
        let viewController = LoginViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController
        router.parent = self.root as? RouterDelegate // what?!
        route(to: navigationController, as: transition)
    }

    func openLogin(userSessionData: UserSessionService) {
        openLogin(with: ModalTransition(), userSessionData: userSessionData)
    }
}
