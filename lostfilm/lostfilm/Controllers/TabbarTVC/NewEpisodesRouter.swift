//
//  NewEpisodesRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

final class NewEpisodesRouter: TemplateRouter {

    override func start() -> UIViewController {
        let dataController = NewEpisodesDataController(router: self)
        let viewController = NewEpisodesTVC(style: .grouped, dataController: dataController)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        self.dataController = dataController
        return navigationController
    }
}
