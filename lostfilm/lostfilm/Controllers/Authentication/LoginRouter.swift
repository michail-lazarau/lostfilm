//
//  LoginRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func showRegistration()
}

final class LoginRouter: DefaultRouter, RegistrationRouterProtocol {
    func openRegistrationViewController() {
        dismiss { [weak self] in
            self?.registrationPresenterDelegate?.showRegistration()
        }
    }

    private weak var registrationPresenterDelegate: RegistrationPresenterProtocol?
    private let userSessionData: UserSessionService

    init(userSessionData: UserSessionService, rootTransition: Transition, registrationPresenterDelegate: RegistrationPresenterProtocol ) {
        self.userSessionData = userSessionData
        self.registrationPresenterDelegate = registrationPresenterDelegate
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
