import Foundation
import XCTest
@testable import lostfilm

class LoginViewModelDelegateMock: LoginViewProtocol {
    var showErrorFuncExpectation = XCTestExpectation(description: "showError(error:) expectation")
    var authoriseFuncExpectation = XCTestExpectation(description: "authorise(username:) expectation")
    var updateCaptchaFuncExpectation = XCTestExpectation(description: "updateCaptcha(data:) expectation")
    var removeLoadingIndicatorFuncExpectation = XCTestExpectation(description: "removeLoadingIndicator() expectation")
    var prepareCaptchaToUpdateFuncExpectation = XCTestExpectation(description: "prepareCaptchaToUpdate() expectation")
    var hideCaptchaWhenFailedToLoadFuncExpectation = XCTestExpectation(description: "hideCaptchaWhenFailedToLoad() expectation") //  описание нужно для дебага 

    var didCallConfirmationMessage: ((String) -> Void)? 
    var didCallEmailErrorMessage: ((String) -> Void)?
    var didCallPasswordConfirmationMessage: ((String) -> Void)?
    var didCallPasswordErrorMessage: ((String) -> Void)?
    var buttonStatus: ((Bool) -> Void)?



    func showError(error: Error) {
        showErrorFuncExpectation.fulfill()
    }

    func authorise(username: String) {
        authoriseFuncExpectation.fulfill()
    }

    func removeLoadingIndicator() {
        removeLoadingIndicatorFuncExpectation.fulfill()
    }

    func updateCaptcha(data: Data) {
        updateCaptchaFuncExpectation.fulfill()
    }

    func prepareCaptchaToUpdate() {
        prepareCaptchaToUpdateFuncExpectation.fulfill()
    }

    func hideCaptchaWhenFailedToLoad() {
        hideCaptchaWhenFailedToLoadFuncExpectation.fulfill()
    }

    func setButtonEnabled(_ isEnable: Bool) {
        buttonStatus?(isEnable)
    }

    func sendEmailConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
        didCallConfirmationMessage?(confirmationMessage)
    }

    func sendPasswordConfirmationMessage(_ confirmationMessage: String, color: UIColor) {
       didCallPasswordConfirmationMessage?(confirmationMessage)
    }

    func sendEmailErrorMessage(_ errorMessage: String, color: UIColor) {
        didCallEmailErrorMessage?(errorMessage)
    }

    func sendPasswordErrorMessage(_ errorMessage: String, color: UIColor) {
        didCallPasswordErrorMessage?(errorMessage)
    }
}
