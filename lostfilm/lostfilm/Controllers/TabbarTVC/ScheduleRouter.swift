//
//  ScheduleRouter.swift
//  lostfilm
//
//  Created by Kiryl Karabeika on 08/12/2022.
//

import Foundation

protocol ScheduleRouterProtocol: TemplateRouterProtocol {

}

final class ScheduleRouter: TemplateRouter, ScheduleRouterProtocol {

    override func start() -> UIViewController {
        let dataController = ScheduleDataController(router: self)
        let viewController = ScheduleTVC(style: .plain, dataController: dataController)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        self.dataController = dataController
        return navigationController
    }
}
