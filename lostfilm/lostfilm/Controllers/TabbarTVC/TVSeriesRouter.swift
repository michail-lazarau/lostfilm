//
//  TVSeriesRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

final class TVSeriesRouter: TemplateRouter {

    override func start() -> UIViewController {
        let dataController = TVSeriesDataController(router: self)
        let viewController = TVSeriesTVC(style: .plain, dataController: dataController)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        self.dataController = dataController
        return navigationController
    }
}
