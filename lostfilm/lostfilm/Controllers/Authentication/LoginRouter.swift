//
//  LoginRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

final class LoginRouter: DefaultRouter {

    private let userSessionData: UserSessionService

    init(userSessionData: UserSessionService, rootTransition: Transition) {
        self.userSessionData = userSessionData
        super.init(rootTransition: rootTransition)
    }

    override func start() -> UIViewController {
        let debouncer = Debouncer(timeInterval: 0.5)
        let viewModel = LoginViewModel(dataProvider: LoginService(session: URLSession.shared), router: self, userSessionData: userSessionData, debouncer: debouncer)
        let viewController = LoginViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        root = navigationController
        return navigationController
    }
}
