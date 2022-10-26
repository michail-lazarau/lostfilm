import Foundation
import XCTest
@testable import lostfilm

class LoginViewModelDelegateMock: LoginViewProtocol {
    var showErrorFuncExpectation = XCTestExpectation(description: "showError(error:) expectation")
    var authoriseFuncExpectation = XCTestExpectation(description: "authorise(username:) expectation")
    var updateCaptchaFuncExpectation = XCTestExpectation(description: "updateCaptcha(data:) expectation")
    var removeLoadingIndicatorFuncExpectation = XCTestExpectation(description: "removeLoadingIndicator() expectation")

    func showError(error: Error) {
        showErrorFuncExpectation.fulfill()
    }

    func authorise(username: String) {
        authoriseFuncExpectation.fulfill()
    }

    func updateCaptcha(data: Data) {
        updateCaptchaFuncExpectation.fulfill()
    }

    func removeLoadingIndicator() {
        removeLoadingIndicatorFuncExpectation.fulfill()
    }
}
