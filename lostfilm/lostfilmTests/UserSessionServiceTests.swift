@testable import lostfilm
import XCTest

final class UserSessionServiceTests: XCTestCase {
    var userSessionData: UserSessionService!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        userSessionData = nil
    }

    func test_positive_convertUsernameIntoInitials1() throws {
        let userSessionData = UserSessionStoredData(sensitiveDataStorage: KeychainMock(),
                                                    httpCookieStorage: HTTPCookieStorageMock(),
                                                    domainUrlForCookies: URL(string: ""))
        userSessionData.username = "Test Username"

        let expectedResult = "TU"
        XCTAssertEqual(userSessionData.userInitials, expectedResult)
    }

    func test_positive_convertUsernameIntoInitials2() throws {
        let userSessionData = UserSessionStoredData(sensitiveDataStorage: KeychainMock(),
                                                    httpCookieStorage: HTTPCookieStorageMock(),
                                                    domainUrlForCookies: URL(string: ""))
        userSessionData.username = " Username "

        let expectedResult = "U"
        XCTAssertEqual(userSessionData.userInitials, expectedResult)
    }

    func test_positive_convertUsernameIntoInitials3() throws {
        let userSessionData = UserSessionStoredData(sensitiveDataStorage: KeychainMock(),
                                                    httpCookieStorage: HTTPCookieStorageMock(),
                                                    domainUrlForCookies: URL(string: ""))
        userSessionData.username = " "

        let expectedResult = "?"
        XCTAssertEqual(userSessionData.userInitials, expectedResult)
    }

    func test_positive_convertUsernameIntoInitials4() throws {
        let userSessionData = UserSessionStoredData(sensitiveDataStorage: KeychainMock(),
                                                    httpCookieStorage: HTTPCookieStorageMock(),
                                                    domainUrlForCookies: URL(string: ""))
        userSessionData.username = ""

        let expectedResult = "?"
        XCTAssertEqual(userSessionData.userInitials, expectedResult)
    }

    func test_positive_convertUsernameIntoInitials5() throws {
        let userSessionData = UserSessionStoredData(sensitiveDataStorage: KeychainMock(),
                                                    httpCookieStorage: HTTPCookieStorageMock(),
                                                    domainUrlForCookies: URL(string: ""))
        userSessionData.username = "? ?"

        let expectedResult = "??"
        XCTAssertEqual(userSessionData.userInitials, expectedResult)
    }

    func test_positive_isAuthorised_True() throws {
        let domainUrl = URL(string: "https://www.lostfilm.tv")!
        let cookie = HTTPCookie(properties: [.domain: "https://www.lostfilm.tv",
                                             .path: "/",
                                             .name: SessionProperties.session.rawValue,
                                             .value: "123",
                                             .secure: "true",
                                             .expires: Date(timeIntervalSinceNow: 60)])!
        let cookieStorage = HTTPCookieStorageMock(with: [cookie], for: domainUrl)
        let userSessionData = UserSessionStoredData(sensitiveDataStorage: KeychainMock(),
                                                    httpCookieStorage: cookieStorage,
                                                    domainUrlForCookies: domainUrl)

        let expectedResult = true
        XCTAssertEqual(userSessionData.isAuthorised, expectedResult)
    }

    func test_positive_isAuthorised_False() throws {
        let domainUrl = URL(string: "https://www.lostfilm.tv")!
        let cookieStorage = HTTPCookieStorageMock(with: [], for: domainUrl)
        let userSessionData = UserSessionStoredData(sensitiveDataStorage: KeychainMock(),
                                                    httpCookieStorage: cookieStorage,
                                                    domainUrlForCookies: domainUrl)

        let expectedResult = false
        XCTAssertEqual(userSessionData.isAuthorised, expectedResult)
    }
}
