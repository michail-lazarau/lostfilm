@testable import lostfilm
import XCTest

class LoginServiceTests: XCTestCase {
    var sut: LoginService<URLSessionMock>!
    let captchaUrlString = "https://www.lostfilm.tv/simple_captcha.php"

    override func setUpWithError() throws {
        sut = LoginService(session: URLSessionMock())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_positive_loginSucceedsWithValidCredentials() throws {
        try verifyLogin(expectedResult: "Michail Lazarev",
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.success, error: nil)) { result, expected in
            XCTAssertEqual(try result.get(), expected)
        }
    }

    func test_negative_loginFailsWithNeedCaptchaError() throws {
        try verifyLogin(expectedResult: LoginServiceError.needCaptcha,
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.fail(type: .needCaptcha), error: nil)) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! LoginServiceError, expected)
            }
        }
    }

    func test_negative_loginFailsWithInvalidCredentialError() throws {
        try verifyLogin(expectedResult: LoginServiceError.invalidCredentials,
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.fail(type: .invalidCredentials), error: nil)) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! LoginServiceError, expected)
            }
        }
    }

    func test_negative_loginFailsWithUnknownErrorNo1() throws {
        try verifyLogin(expectedResult: LoginServiceError.unknownLoginError,
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.fail(type: .genericOne), error: nil)) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! LoginServiceError, expected)
            }
        }
    }

    func test_negative_loginFailsWithInvalidCaptchaError() throws {
        try verifyLogin(expectedResult: LoginServiceError.invalidCaptcha,
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.fail(type: .invalidCaptcha), error: nil)) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! LoginServiceError, expected)
            }
        }
    }

    func test_negative_loginFailsWithDecodingError() throws {
        try verifyLogin(expectedResult: DataTaskError.invalidJSON(),
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.fail(type: .undecodable), error: nil)) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! DataTaskError, expected)
            }
        }
    }

    func test_negative_loginFailsWithRequestError() throws {
        try verifyLogin(expectedResult: URLError(.badURL),
                        mockedResponse: LoginResponseMock(body: nil, error: URLError(URLError.Code.badURL))) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! URLError, expected)
            }
        }
    }

    func test_positive_captchaReceived() throws {
        let expectedCaptchaUrl = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "testCaptchaImage", ofType: "gif"), "Unable to generate the url from the local context")
        let expected = try Data(contentsOf: URL(fileURLWithPath: expectedCaptchaUrl))

        try verifyGetCaptcha(expectedResult: expected, mockedResponse: CaptchaResponseMock(body: expected, error: nil)) { result, expected in
            XCTAssertEqual(try result.get(), expected)
        }
    }

    func test_negative_captchaBadUrl() throws {
        try verifyGetCaptcha(expectedResult: URLError(.badURL), mockedResponse: CaptchaResponseMock(body: nil, error: URLError(.badURL))) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! URLError, expected)
            }
        }
    }

    func test_positive_loginPageRenderedWithNoCaptchaRequired() throws {
        let expected = LFLoginPageModel(data: [LFLoginPageModel.Property.captchaStyleDisplay.stringValue: "display:none",
                                               LFLoginPageModel.Property.captchaUrl.stringValue: captchaUrlString])

        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithNoCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        try verifyGetLoginPage(expectedResult: expected, urlStub: url) { result, expected in
            XCTAssertEqual(try result.get(), expected)
        }
    }

    func test_positive_loginPageRenderedWithCaptchaRequired() throws {
        let expected = LFLoginPageModel(data: [LFLoginPageModel.Property.captchaUrl.stringValue: captchaUrlString])

        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageRenderedWithCaptchaRequired", ofType: "html"), "Unable to generate the url from the local context")

        try verifyGetLoginPage(expectedResult: expected, urlStub: url) { result, expected in
            XCTAssertEqual(try result.get(), expected)
        }
    }

    func test_negative_loginPageNotRendered() throws {
        let expected = DVHtmlError.failedToLoadOnUrl
        let url = "stub"

        try verifyGetLoginPage(expectedResult: expected, urlStub: url) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! DVHtmlError, expected)
            }
        }
    }

    func test_negative_loginPageElementNotFound() throws {
        let expected = DVHtmlError.failedToParseCaptchaElement

        let url = try XCTUnwrap(Bundle(for: type(of: self)).path(forResource: "LoginPageElementNotFound", ofType: "html"), "Unable to generate the url from the local context")

        try verifyGetLoginPage(expectedResult: expected, urlStub: url) { result, expected in
            XCTAssertThrowsError(try result.get(), "Catching error") { error in
                XCTAssertEqual(error as! DVHtmlError, expected)
            }
        }
    }
}

extension LoginServiceTests {
    func verifyLogin<T>(expectedResult: T, mockedResponse: LoginResponseMock, assertHandler: (Result<String, Error>, T) throws -> Void) throws {
        // Given
        var loginResponse: Result<String, Error>!

        let exp = expectation(description: "Requesting data")
        sut.session.data = mockedResponse.body?.data
        sut.session.error = mockedResponse.error
        // When
        sut.login(email: "mocked", password: "mocked", captcha: nil) { result in
            exp.fulfill()
            loginResponse = result
        }
        waitForExpectations(timeout: 0.1)
        // Then
        try assertHandler(loginResponse, expectedResult)
    }

    func verifyGetLoginPage<T>(expectedResult: T, urlStub: String, assertHandler: (Result<LFLoginPageModel, Error>, T) throws -> Void) throws {
        // Given
        var loginPageResponse: Result<LFLoginPageModel, Error>!

        let exp = expectation(description: "Requesting data")
        guard let htmlToModel = DVHtmlToModels(contextByName: "GetLoginPageContext") else {
            return XCTFail("Unable to generate the html model from the local context")
        }
        // faking session url
        htmlToModel.setValue("file://" + urlStub, forKey: "url")

        // When
        sut.getLoginPage(htmlParserWrapper: htmlToModel, response: { result in
            exp.fulfill()
            loginPageResponse = result
        })
        waitForExpectations(timeout: 0.1)

        // Then
        try assertHandler(loginPageResponse, expectedResult)
    }

    func verifyGetCaptcha<T>(expectedResult: T, mockedResponse: CaptchaResponseMock, assertHandler: (Result<Data, Error>, T) throws -> Void) throws {
        // Given
        var captchaResponse: Result<Data, Error>!

        let exp = expectation(description: "Requesting data")
        sut.session.data = mockedResponse.body
        sut.session.error = mockedResponse.error

        // When
        sut.getCaptcha(url: URL(string: "Stub")!, response: { result in
            exp.fulfill()
            captchaResponse = result
        })
        waitForExpectations(timeout: 0.1)

        // Then
        // XCTestFail
        try assertHandler(captchaResponse, expectedResult)
    }
}
