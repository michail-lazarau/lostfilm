@testable import lostfilm
import XCTest

class LoginViewModelTests: XCTestCase {
    var sut: LoginViewModel!
    var delegate: LoginViewModelDelegateMock!

    override func setUpWithError() throws {
        sut = LoginViewModel(dataProvider: LoginService(session: URLSessionMock()))
        delegate = LoginViewModelDelegateMock()
        sut.loginViewModelDelegate = delegate
    }

    override func tearDownWithError() throws {
        sut = nil
        delegate = nil
    }

    // MARK: captcha
    func test_nagative_showErrorForCaptchaCheck() throws {
        let url = "stub"

        delegate.prepareCaptchaToDisplayFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.prepareCaptchaToDisplayFuncExpectation, delegate.showErrorFuncExpectation]

        try verifyCheckForCaptcha(email: "", password: "", captcha: nil, expectedCaptcha: nil, expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func test_positive_renderCaptchaWhenCaptchaRequired() throws {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting captcha response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = Data()

        delegate.authoriseFuncExpectation.isInverted = true
        delegate.showErrorFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.prepareCaptchaToDisplayFuncExpectation, delegate.updateCaptchaFuncExpectation, delegate.authoriseFuncExpectation, delegate.showErrorFuncExpectation]

        try verifyCheckForCaptcha(email: "", password: "", captcha: nil, expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: true, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!), expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func test_negative_renderCaptchaReceiveErrorInResponse() throws {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting captcha response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.error = URLError(.badURL)

        delegate.updateCaptchaFuncExpectation.isInverted = true
        delegate.authoriseFuncExpectation.isInverted = true

        let expectations: [XCTestExpectation] = [delegate.prepareCaptchaToDisplayFuncExpectation, delegate.showErrorFuncExpectation, delegate.updateCaptchaFuncExpectation, delegate.authoriseFuncExpectation]

        try verifyCheckForCaptcha(email: "", password: "", captcha: nil, expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: true, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!), expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    // MARK: Login
    func test_positive_loginSucceededWithCaptchaNotRequired() throws {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.success, error: nil).body?.data

        delegate.prepareCaptchaToDisplayFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.prepareCaptchaToDisplayFuncExpectation, delegate.authoriseFuncExpectation]

        try verifyCheckForCaptcha(email: "Mocked", password: "Mocked", captcha: nil, expectedCaptcha: nil, expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func test_positive_loginSucceededWithCaptchaRequired() throws {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        sut.htmlParserWrapper.setValue("file://" + url, forKey: "url") // faking session url
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = Data()
        sut.checkForCaptcha(email: "Mocked", password: "Mocked", captcha: "Mocked")
        wait(for: [delegate.updateCaptchaFuncExpectation], timeout: 0.1)

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.success, error: nil).body?.data

        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation]

        try verifyCheckForCaptcha(email: "Mocked", password: "Mocked", captcha: "Mocked", expectedCaptcha: nil, expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func test_negative_loginFailedDueToNeedCaptchaError() throws {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.fail(type: .needCaptcha), error: nil).body?.data

        delegate.authoriseFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.showErrorFuncExpectation, delegate.prepareCaptchaToDisplayFuncExpectation]

        // do i need check captcha here? I guess no
        try verifyCheckForCaptcha(email: "Mocked", password: "Mocked", captcha: nil, expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: false, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!), expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func test_negative_loginFailedDueToInvalidCaptchaError() throws {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.fail(type: .invalidCaptcha), error: nil).body?.data

        delegate.authoriseFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.showErrorFuncExpectation, delegate.prepareCaptchaToDisplayFuncExpectation]

        // do i need check captcha here? I guess no
        try verifyCheckForCaptcha(email: "Mocked", password: "Mocked", captcha: nil, expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: false, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!), expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func test_negative_loginFailedDueToInvalidCredentialsError() throws {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.fail(type: .invalidCredentials), error: nil).body?.data

        delegate.authoriseFuncExpectation.isInverted = true
        delegate.prepareCaptchaToDisplayFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.showErrorFuncExpectation, delegate.prepareCaptchaToDisplayFuncExpectation]

        // do i need check captcha here? I guess no
        try verifyCheckForCaptcha(email: "Mocked", password: "Mocked", captcha: nil, expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: false, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!), expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func test_negative_loginFailedDueToUnknownLoginError() throws {
        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.fail(type: .genericOne), error: nil).body?.data

        delegate.authoriseFuncExpectation.isInverted = true
        delegate.prepareCaptchaToDisplayFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.showErrorFuncExpectation, delegate.prepareCaptchaToDisplayFuncExpectation]

        // do i need check captcha here? I guess no
        try verifyCheckForCaptcha(email: "Mocked", password: "Mocked", captcha: nil, expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: false, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!), expectations: expectations, urlStub: url, assertHandler: { result, expected in
            XCTAssertEqual(result, expected)
        })
    }

    func verifyCheckForCaptcha(email: String, password: String, captcha: String?, expectedCaptcha: LoginViewModel.Captcha?, expectations: [XCTestExpectation], urlStub: String, assertHandler: (LoginViewModel.Captcha?, LoginViewModel.Captcha?) throws -> Void) throws {
        // Given
        sut.htmlParserWrapper.setValue("file://" + urlStub, forKey: "url") // faking session url

        // When
        sut.checkForCaptcha(email: email, password: password, captcha: captcha)
        wait(for: expectations, timeout: 0.1)

        // Then
        try assertHandler(sut.captchaModel, expectedCaptcha)
    }
}
