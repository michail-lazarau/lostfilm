import Foundation
import XCTest
@testable import lostfilm

// MARK: mock transition
// https://cassiuspacheco.com/unit-testing-composable-routing-in-swift-for-ios-apps-part-3
class DefaultRouterMock: NSObject, Router, Closable, Dismissable {

    var parent: lostfilm.RouterDelegate?

    func start() -> UIViewController {
        UIViewController()
    }

    func route(to router: lostfilm.Router, using transition: lostfilm.Transition) {

    }

    func route(to router: lostfilm.Router, using transition: lostfilm.Transition, completion: (() -> Void)?) {

    }

    var root: UIViewController?

    var closeWithCompletionFuncExpectation = XCTestExpectation(description: "close(completion:) expectation")
    var dismissWithCompletionFuncExpectation = XCTestExpectation(description: "dismiss(completion:) expectation")
    var routeWithCompletionFuncExpectation = XCTestExpectation(description: "route(to: as: completion:) expectation")

    func close() {
        close(completion: nil)
    }

    func close(completion: (() -> Void)?) {
        closeWithCompletionFuncExpectation.fulfill()
    }

    func dismiss() {
        dismiss(completion: nil)
    }

    func dismiss(completion: (() -> Void)?) {
        dismissWithCompletionFuncExpectation.fulfill()
    }

    func route(to viewController: UIViewController, as transition: lostfilm.Transition) {
        route(to: viewController, as: transition, completion: nil)
    }

    func route(to viewController: UIViewController, as transition: lostfilm.Transition, completion: (() -> Void)?) {
        routeWithCompletionFuncExpectation.fulfill()
    }
}
