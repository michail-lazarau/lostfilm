//
//  MockRegistrationRouter.swift
//  lostfilmTests
//
//  Created by u.yanouski on 2023-01-24.
//

import Foundation
import XCTest
@testable import lostfilm

final class MockRegistrationRouter {

    var showCallFuncOpenProfileViewControllerExpectation = XCTestExpectation(description: "OpenProfileViewController() expectation")
    var showCallFuncOpenPhotoViewControllerExpectation = XCTestExpectation(description: "openPhotoViewController() expectation")
    var showCallFuncCloseControllerExpectation = XCTestExpectation(description: "CloseController() expectation")
    var showCallOpenRegistrationViewControllerExpectation = XCTestExpectation(description: "OpenRegistrationViewController() expectation")

    var dismissWithCompletionFuncExpectation = XCTestExpectation(description: "dismiss(completion:) expectation")



    func incrementOpenRegistrationViewControllerCall() {
        showCallOpenRegistrationViewControllerExpectation.fulfill()
    }

    func incrementProfileControllerCall() {
       showCallFuncOpenProfileViewControllerExpectation.fulfill()
    }

    func incrementPhotoControllerCall() {
        showCallFuncOpenPhotoViewControllerExpectation.fulfill()
    }

    func incrementCloseControllerCall() {
        showCallFuncCloseControllerExpectation.fulfill()
    }
}

extension MockRegistrationRouter: RegistrationRouterProtocol, Dismissable {
    func dismiss(completion: (() -> Void)?) {
        dismissWithCompletionFuncExpectation.fulfill()
    }

    func dismiss() {
        dismissWithCompletionFuncExpectation.fulfill()
    }

    func openRegistrationViewController() {
        print("openProfileViewController()")
        incrementProfileControllerCall()
    }
}

extension MockRegistrationRouter: DetailInformationProtocol {
    func openPhotoViewController() {
        print("func openPhotoViewController()")
        incrementPhotoControllerCall()
    }
}

extension MockRegistrationRouter: PhotoViewRouterProtocol {
    func closeController() {
        print("func closeController()")
        incrementCloseControllerCall()
    }
}
