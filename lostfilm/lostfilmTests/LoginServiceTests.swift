@testable import lostfilm
import XCTest

class LoginServiceTests: XCTestCase {
    var sut: LoginService<URLSessionMock>!

    override func setUpWithError() throws {
        sut = LoginService(session: URLSessionMock())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_positive_loginSucceedsWithValidCredentials() throws {
        try verifyLogin(expectedResult: "Michail Lazarev",
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.success, error: nil)) {
            result, expected in
            XCTAssertEqual(try result.get(), expected)
        }
    }

    func test_negative_loginFailsWithNeedCaptchaError() throws {
        try verifyLogin(expectedResult: LoginServiceError.needCaptcha,
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.fail(type: .needCaptcha), error: nil)) {
            result, expected in
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

    func test_negative_loginFailsWithUnknownErrorNo4() throws {
        try verifyLogin(expectedResult: LoginServiceError.unknownLoginError,
                        mockedResponse: LoginResponseMock(body: LoginResponseBodyMock.fail(type: .genericFour), error: nil)) { result, expected in
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
}

extension LoginServiceTests {
    func verifyLogin<T>(expectedResult: T, mockedResponse: LoginResponseMock, assertHandler: (Result<String, Error>, T) throws -> Void) throws -> Void {
        // Given
        var loginResponse: Result<String, Error>!

        let exp = expectation(description: "Requesting data")
        sut.session.data = mockedResponse.body?.data
        sut.session.error = mockedResponse.error
        // When
        sut.login(request: URLRequest(url: URL(string: "mocked")!)) { result in
            exp.fulfill()
            loginResponse = result
        }
        waitForExpectations(timeout: 0.1)
        // Then
        try assertHandler(loginResponse, expectedResult)
    }
}
