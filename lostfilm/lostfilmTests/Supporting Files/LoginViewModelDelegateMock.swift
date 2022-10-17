import Foundation
import XCTest
@testable import lostfilm

class LoginViewModelDelegateMock: LoginViewProtocol {
    var showErrorFuncExpectation: XCTestExpectation = XCTestExpectation(description: "showError(error:) expectation")
    var authoriseFuncExpectation: XCTestExpectation = XCTestExpectation(description: "authorise(username:) expectation")
    var prepareCaptchaToDisplayFuncExpectation: XCTestExpectation = XCTestExpectation(description: "prepareCaptchaToDisplay() expectation")
    var updateCaptchaFuncExpectation: XCTestExpectation = XCTestExpectation(description: "updateCaptcha(data:) expectation")

    func showError(error: Error) {
        showErrorFuncExpectation.fulfill()
    }

    func authorise(username: String) {
        authoriseFuncExpectation.fulfill()
    }

    func prepareCaptchaToDisplay() {
        prepareCaptchaToDisplayFuncExpectation.fulfill()
    }

    func updateCaptcha(data: Data) {
        updateCaptchaFuncExpectation.fulfill()
    }

    func displayLoadingIndicator() {
//        <#code#>
    }

    func removeLoadingIndicator() {
//        <#code#>
    }
}
