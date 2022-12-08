//
//  TemplateRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

protocol TemplateRouterProtocol {
    func showLogin()
    func showProfile()
}

class TemplateRouter: DefaultRouter, TemplateRouterProtocol {

    weak var dataController: TabModuleInput?
    private weak var loginRoute: LoginRoute?

    init(loginRoute: LoginRoute, rootTransition: Transition) {
        self.loginRoute = loginRoute
        super.init(rootTransition: rootTransition)
    }

    func showLogin() {
        loginRoute?.openLogin()
    }

    func showProfile() {
        print("TODO show profile")
    }
}
