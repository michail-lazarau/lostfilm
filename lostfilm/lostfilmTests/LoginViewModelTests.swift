@testable import lostfilm
import XCTest

class LoginViewModelTests: XCTestCase {
    typealias Credentials = (email: String, password: String, captcha: String?)
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

    func test_negative_showErrorForCaptchaCheck() throws {
        let mockUrlForGetLoginPageFunc = "mock"

        let expectations: [XCTestExpectation] = [delegate.showErrorFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", nil),
                    expectedCaptcha: nil,
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    func test_positive_renderCaptchaWhenRequired() throws {
        let mockUrlForGetLoginPageFunc = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = Data() // faking successful response to get a captcha *1

        delegate.authoriseFuncExpectation.isInverted = true
        delegate.showErrorFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.prepareCaptchaToUpdateFuncExpectation, delegate.updateCaptchaFuncExpectation, delegate.authoriseFuncExpectation, delegate.showErrorFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", nil),
                    expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: true, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!),
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    func test_negative_renderCaptchaReceiveErrorInResponse() throws {
        let mockUrlForGetLoginPageFunc = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.error = URLError(.badURL)

        delegate.updateCaptchaFuncExpectation.isInverted = true
        delegate.authoriseFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.hideCaptchaWhenFailedToLoadFuncExpectation, delegate.showErrorFuncExpectation, delegate.updateCaptchaFuncExpectation, delegate.authoriseFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", nil),
                    expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: true, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!),
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    // MARK: Login

    func test_positive_loginSucceededWithNoCaptchaRequired() throws {
        let mockUrlForGetLoginPageFunc = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.success, error: nil).body?.data

        delegate.updateCaptchaFuncExpectation.isInverted = true
        delegate.showErrorFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.updateCaptchaFuncExpectation, delegate.showErrorFuncExpectation, delegate.authoriseFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", nil),
                    expectedCaptcha: nil,
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    func test_positive_loginSucceededWithCaptchaRequired() throws {
        let mockUrlForGetLoginPageFunc = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // Given: requesting login to get a captcha (because it cannot be set directly to the LoginViewModel)
        sut.htmlParserWrapper.setValue("file://" + mockUrlForGetLoginPageFunc, forKey: "url") // faking session url *1
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = Data() // faking successful response to get a captcha *1
        sut.login(email: "Mocked", password: "Mocked", captcha: "Mocked")
        wait(for: [delegate.updateCaptchaFuncExpectation], timeout: 0.1)

        // Given: setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.success, error: nil).body?.data

        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", "Mocked"),
                    expectedCaptcha: nil,
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    func test_negative_loginFailedDueToNeedCaptchaError() throws {
        let mockUrlForGetLoginPageFunc = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // Given: requesting login to get a captcha (because it cannot be set directly to the LoginViewModel)
        sut.htmlParserWrapper.setValue("file://" + mockUrlForGetLoginPageFunc, forKey: "url") // faking session url *1
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = Data() // faking successful response to get a captcha *1
        sut.login(email: "Mocked", password: "Mocked", captcha: "Mocked")
        wait(for: [delegate.updateCaptchaFuncExpectation], timeout: 0.1)

        // Given: setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.fail(type: .needCaptcha), error: nil).body?.data

            // resetting updateCaptchaFuncExpectation to reuse
        delegate.updateCaptchaFuncExpectation = XCTestExpectation(description: "updateCaptcha(data:) expectation")

        delegate.authoriseFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.updateCaptchaFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation, delegate.showErrorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", nil),
                    expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: true, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!),
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    func test_negative_loginFailedDueToInvalidCaptchaError() throws {
        let mockUrlForGetLoginPageFunc = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // Given: requesting login to get a captcha (because it cannot be set directly to the LoginViewModel)
        sut.htmlParserWrapper.setValue("file://" + mockUrlForGetLoginPageFunc, forKey: "url") // faking session url *1
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = Data() // faking successful response to get a captcha *1
        sut.login(email: "Mocked", password: "Mocked", captcha: "Mocked")
        wait(for: [delegate.updateCaptchaFuncExpectation], timeout: 0.1)

        // Given: setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.fail(type: .invalidCaptcha), error: nil).body?.data

            // resetting updateCaptchaFuncExpectation to reuse
        delegate.updateCaptchaFuncExpectation = XCTestExpectation(description: "updateCaptcha(data:) expectation")

        delegate.authoriseFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.updateCaptchaFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation, delegate.showErrorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", nil),
                    expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: true, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!),
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    func test_negative_loginFailedDueToInvalidCredentialsError() throws {
        let mockUrlForGetLoginPageFunc = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // Given: setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.fail(type: .invalidCredentials), error: nil).body?.data

        delegate.authoriseFuncExpectation.isInverted = true
        delegate.prepareCaptchaToUpdateFuncExpectation.isInverted = true
        delegate.updateCaptchaFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.prepareCaptchaToUpdateFuncExpectation, delegate.updateCaptchaFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation, delegate.showErrorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", nil),
                    expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: false, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!),
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    func test_negative_loginFailedDueToUnknownLoginError() throws {
        let mockUrlForGetLoginPageFunc = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        // setting login response
        (sut.dataProvider as! LoginService<URLSessionMock>).session.data = LoginResponseMock(body: LoginResponseBodyMock.fail(type: .genericOne), error: nil).body?.data

        delegate.authoriseFuncExpectation.isInverted = true
        delegate.prepareCaptchaToUpdateFuncExpectation.isInverted = true
        delegate.updateCaptchaFuncExpectation.isInverted = true
        let expectations: [XCTestExpectation] = [delegate.authoriseFuncExpectation, delegate.prepareCaptchaToUpdateFuncExpectation, delegate.updateCaptchaFuncExpectation, delegate.removeLoadingIndicatorFuncExpectation, delegate.showErrorFuncExpectation]

        verifyLogin(credentials: ("Mocked", "Mocked", nil),
                    expectedCaptcha: LoginViewModel.Captcha(captchaIsRequired: false, captchaUrl: URL(string: "https://www.lostfilm.tv/simple_captcha.php")!),
                    expectations: expectations,
                    mockUrlForLoginPage: mockUrlForGetLoginPageFunc)
    }

    func verifyLogin(credentials: Credentials, expectedCaptcha: LoginViewModel.Captcha?, expectations: [XCTestExpectation], mockUrlForLoginPage: String) {
        // Given
        sut.htmlParserWrapper.setValue("file://" + mockUrlForLoginPage, forKey: "url") // faking session url *1

        // When
        sut.login(email: credentials.email, password: credentials.password, captcha: credentials.captcha)
        wait(for: expectations, timeout: 0.1)

        // Then
        XCTAssertEqual(sut.captchaModel, expectedCaptcha)
    }
}

// *1: for LoginServiceProtocol.getLoginPage(htmlParserWrapper:, response:)
