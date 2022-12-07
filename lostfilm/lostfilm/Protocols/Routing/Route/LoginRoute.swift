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
        router.routerDelegate = self.root as? RouterDelegate // what?!
//        viewController.profileButtonDelegate = (self as! DefaultRouter).root as! any ProfileButtonDelegate  // new
        route(to: navigationController, as: transition)
    }

    func openLogin(userSessionData: UserSessionService) {
        openLogin(with: ModalTransition(), userSessionData: userSessionData)
    }
}
