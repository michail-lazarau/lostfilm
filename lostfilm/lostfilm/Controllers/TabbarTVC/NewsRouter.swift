//
//  NewsRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

final class NewsRouter: TemplateRouter {

    override func start() -> UIViewController {
        let dataController = NewsDataController(router: self)
        let viewController = NewsTVC(style: .plain, dataController: dataController)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        self.dataController = dataController
        return navigationController
    }
}
