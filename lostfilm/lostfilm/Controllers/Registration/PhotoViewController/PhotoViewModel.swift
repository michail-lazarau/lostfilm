//
//  PhotoViewModel.swift
//  lostfilm
//
//  Created by u.yanouski on 2023-01-19.
//

import Foundation

protocol PhotoViewModelProtocol: AnyObject {
    func photoButtonAction()
    func doneButtonAction()
    func viewReady(_ view: PhotoViewRouterProtocol)
}

final class PhotoViewModel {
    var view: PhotoViewRouterProtocol?
    private let router: PhotoViewRouterProtocol

    init(view: PhotoViewRouterProtocol? = nil, router: PhotoViewRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension PhotoViewModel: PhotoViewModelProtocol {
    func photoButtonAction() {
        print("PhotoButton clicked")
    }

    func doneButtonAction() {
        print("DONE BUTTON clicked")
        router.closeController()
    }

    func viewReady(_ view: PhotoViewRouterProtocol) {
        self.view = view
    }
}
