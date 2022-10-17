@testable import lostfilm
import XCTest

class LoginViewModelTests: XCTestCase {
    var sut: LoginViewModel!

    override func setUpWithError() throws {
        sut = LoginViewModel(dataProvider: LoginService(session: URLSessionMock()))
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_nagative_showErrorForCaptchaCheck() throws {
        let delegate = LoginViewModelDelegateMock()
        sut.loginViewModelDelegate = delegate
        let loginViewModelDelegate = sut.loginViewModelDelegate as! LoginViewModelDelegateMock
        let url = "stub"

        loginViewModelDelegate.prepareCaptchaToDisplayFuncExpectation.isInverted = true

        let expectations: [XCTestExpectation] = [loginViewModelDelegate.showErrorFuncExpectation, loginViewModelDelegate.prepareCaptchaToDisplayFuncExpectation]

        try verifyCheckForCaptcha(eMail: "", password: "", captcha: nil, expectedCaptcha: nil, expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func test_positive_renderCaptchaWhenCaptchaRequired() throws {
        let delegate = LoginViewModelDelegateMock()
        sut.loginViewModelDelegate = delegate
        let loginViewModelDelegate = sut.loginViewModelDelegate as! LoginViewModelDelegateMock
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = Data()

        let expectations: [XCTestExpectation] = [loginViewModelDelegate.prepareCaptchaToDisplayFuncExpectation, loginViewModelDelegate.updateCaptchaFuncExpectation]

        try verifyCheckForCaptcha(eMail: "", password: "", captcha: nil, expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: true, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!), expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func verifyCheckForCaptcha(eMail: String, password: String, captcha: String?, expectedCaptcha: LoginViewModel.Captcha?, expectations: [XCTestExpectation], urlStub: String, assertHandler: (LoginViewModel.Captcha?, LoginViewModel.Captcha?) throws -> Void) throws {
        // Given
        sut.htmlParserWrapper.setValue("file://" + urlStub, forKey: "url") // faking session url

        // When
        sut.checkForCaptcha(eMail: eMail, password: password, captcha: captcha)
        wait(for: expectations, timeout: 0.1)

        // Then
        try assertHandler(sut.captchaModel, expectedCaptcha)
    }
}
