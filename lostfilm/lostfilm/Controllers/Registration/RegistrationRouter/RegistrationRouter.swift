//
//  RegistrationRouter.swift
//  lostfilm
//
//  Created by u.yanouski on 2023-01-11.
//

import Foundation

protocol RegistrationRouterProtocol: Dismissable {
    func openRegistrationViewController()
}

protocol DetailInformationProtocol {
    func openPhotoViewController()
}

protocol PhotoViewRouterProtocol {
    func closeController()
}

final class RegistrationRouter: DefaultRouter {

    override func start() -> UIViewController {
        let viewController = RegistrationViewController(viewModel: RegistrationViewModel(debouncer: Debouncer(timeInterval: 0.5), router: self))
        let navigationController = UINavigationController(rootViewController: viewController)
        root = navigationController
        return navigationController
    }
}

extension RegistrationRouter: RegistrationRouterProtocol, DetailInformationProtocol, PhotoViewRouterProtocol {

    func openRegistrationViewController() {
        let viewController = ProfileViewController(viewModel: ProfileViewModel(countryService: CountryService(), debouncer: Debouncer(timeInterval: 0.5), router: self))
        route(to: viewController, as: PushTransition(isAnimated: true))
    }

    func openPhotoViewController() {
        let viewController = PhotoViewController(imagePickerController: UIImagePickerController(), viewModel: PhotoViewModel(router: self))
        route(to: viewController, as: PushTransition(isAnimated: true))
    }

    func closeController() {
        close()
    }
}
