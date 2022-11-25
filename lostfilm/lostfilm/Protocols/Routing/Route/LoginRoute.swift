import Foundation

protocol LoginRoute {
    func openLogin()
}

extension LoginRoute where Self: Router {
    func openLogin(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = LoginViewModel(dataProvider: LoginService(session: URLSession.shared), router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        router.root = viewController

        route(to: navigationController, as: transition)
    }

    func openLogin() {
        openLogin(with: ModalTransition())
    }
}
