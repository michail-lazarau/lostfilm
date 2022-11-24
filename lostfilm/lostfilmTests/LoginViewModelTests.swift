@testable import lostfilm
import XCTest

class LoginViewModelTests: XCTestCase {
    typealias Credentials = (email: String, password: String, captcha: String?)
    var sut: LoginViewModel!
    var delegate: LoginViewModelDelegateMock!

    override func setUpWithError() throws {
        sut = LoginViewModel(dataProvider: LoginService(session: URLSessionMock()))
        delegate = LoginViewModelDelegateMock()
        sut.view = delegate
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

    //MARK: Validator

    // MARK: sendMessage Functionality
    func test_showEmailConfirmation() { // rename func sendConfirmationEmailMessage ||
        let sendEmailConfirmationMessage = XCTestExpectation(description: "sendEmailConfirmationMessage()  expectation") // механизм ожидания Почитать //1
        delegate.didCallConfirmationMessage = { message in // !2! присловли кусок кода переменной   message  значение которое пришло в клоужер из функции sendEmailConfiramtionMessage// Присвоили переменной тип Клоужера

            XCTAssertEqual(message, ValidationConfirmation.validEmail) // cравнивааем то что пришло с ожидаемой строкой // 4
            sendEmailConfirmationMessage.fulfill() //   ждем пока придет сообщение //5
        }
        sut.didEnterEmailTextFieldWithString(emailViewString: "test@gmail.com") // 3
        wait(for: [sendEmailConfirmationMessage], timeout: 0) // 6 Ждем пока выполняется sendEmailConfirmationMessage.fulfill() но не более указаного времени в timeout
    }

    func test_sendErrorEmailMessage() {
        let sendEmailErrorMessage = XCTestExpectation(description: "sendEmailErrorMessage() expectation")
        delegate.didCallEmailErrorMessage = { message in
            XCTAssertEqual(message, ValidationError.invalidEmail.localizedDescription)
            sendEmailErrorMessage.fulfill()
        }
        sut.didEnterEmailTextFieldWithString(emailViewString: "InvalidEmail")
        wait(for: [sendEmailErrorMessage], timeout: 1)
    }

    func test_sendConfirmationPasswordMessage() {
        let sendPasswordConfirmationMessage = XCTestExpectation(description: "sendPasswordConfirmationMessage() expectation")
        delegate.didCallPasswordConfirmationMessage = { message in
            XCTAssertEqual(message, ValidationConfirmation.validPassword)
            sendPasswordConfirmationMessage.fulfill()
        }
        sut.didEnterPasswordTextFieldWithString(passwordViewString: "ASPgo123")
        wait(for: [sendPasswordConfirmationMessage], timeout: 0)
    }

    func test_sendPasswordErrorMessage() {
        let sendPasswordErrorMessage = XCTestExpectation(description: "sendPasswordErrorMessage() expectation")
        delegate.didCallPasswordErrorMessage = { message in
            XCTAssertEqual(message, ValidationError.invalidPassword.localizedDescription)
            sendPasswordErrorMessage.fulfill()
        }
        sut.didEnterPasswordTextFieldWithString(passwordViewString: "InvalidPassword")
        wait(for: [sendPasswordErrorMessage], timeout: 0)
    }

    // MARK: Button isEnbaled

    func test_isLoginButtonEnabledWithoutCaptcha() { 
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonEnabledWithoutCaptchaAllDataIsCorrect() expectation" )
        delegate.buttonStatus = { isEnabled in
            XCTAssertTrue(isEnabled)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "ValidEmail@gmail.com", passwordViewString: "ASPgo123", captchaViewString: nil, isCaptchaHidden: true)
    }

    func test_isLoginButtonEnabledWithCaptcha() {
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonEnabledWithCaptcha expectation" )
        delegate.buttonStatus = { isEnable in
            XCTAssertTrue(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "ValidEmail@gmail.com", passwordViewString: "ASPgo123", captchaViewString: "captcha", isCaptchaHidden: false)
    }

    // MARK: Button isDisabled

    // MARK: Button isDisabled without Captcha
    func test_isLoginButtonDisabledWithoutCaptchaAllTextFieldsIsEmpty() {
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonDisabledWithoutCaptchaAllTextFieldsIsEmpty() expectation" )
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "", passwordViewString: "", captchaViewString: nil, isCaptchaHidden: true)
    }

    func test_isLoginButtonDisabledWithoutCaptchaEmailIsValid() {
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonDisabledWithoutCaptchaEmailIsValid() expectation" )
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "ValidEmail@gmail.com", passwordViewString: "", captchaViewString: nil, isCaptchaHidden: true)
    }

    func test_isLoginButtonDisabledWithoutCaptchaPasswordIsValid() {
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonDisabledWithoutCaptchaPasswordIsValid() expectation" )
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "Invalid", passwordViewString: "ASPgo123", captchaViewString: nil, isCaptchaHidden: true)
    }

    // MARK: Button isDisabled with Captcha
    func test_isLoginButtonDisabledWithCaptchaAllTextFieldsIsEmpty() {
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonDisabledWithoutCaptchaCaptchaStringIsNotEmpty() expectation" )
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "", passwordViewString: "", captchaViewString: nil, isCaptchaHidden: false)
    }

    func test_isLoginButtonDisabledWithCaptchaEmailIsValid() {
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonDisabledWithoutCaptchaEmailIsValid() expectation" )
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "ValidEmail@gmail.com", passwordViewString: "", captchaViewString: nil, isCaptchaHidden: false)
    }

    func test_isLoginButtonDisabledWithCaptchaPasswordIsValid() {
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonDisabledWithoutCaptchaEmailIsValid() expectation" )
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "Invalid", passwordViewString: "ASPgo123", captchaViewString: nil, isCaptchaHidden: false)
    }

    func test_isLoginButtonDisabledWithCaptchaCaptchaStringIsNotEmpty() {
        let buttonExpectation = XCTestExpectation(description: "test_isLoginButtonDisabledWithoutCaptchaCaptchaStringIsNotEmpty() expectation" )
        delegate.buttonStatus = { isEnable in
            XCTAssertFalse(isEnable)
            buttonExpectation.fulfill()
        }
        sut.checkButtonStatus(emailViewString: "Invalid", passwordViewString: "AS", captchaViewString: "captcha", isCaptchaHidden: false)
    }
}

// *1: for LoginServiceProtocol.getLoginPage(htmlParserWrapper:, response:)
