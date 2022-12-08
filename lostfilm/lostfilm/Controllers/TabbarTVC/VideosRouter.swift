//
//  VideosRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

final class VideosRouter: TemplateRouter {

    override func start() -> UIViewController {
        let dataController = VideosDataController(router: self)
        let viewController = VideosTVC(style: .plain, dataController: dataController)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        self.dataController = dataController
        return navigationController
    }
}
