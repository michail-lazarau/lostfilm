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

    func testExample() throws {

//        guard let htmlToModel = DVHtmlToModels(contextByName: "GetLoginPageContext") else {
//            return XCTFail("Unable to generate the html model from the local context")
//        }
        sut.getLoginPage(response: <#T##(Result<LoginViewModel.Captcha, Error>) -> Void#>)
    }

    func verifyGetLoginPage<T>(expectedResult: T, urlStub: String, assertHandler: (Result<LoginViewModel.Captcha, Error>, T) throws -> Void) throws {
        // Given
        var loginPageResponse: Result<LoginViewModel.Captcha, Error>!

        let exp = expectation(description: "Requesting data")
        // faking session url
        sut.htmlParserWrapper.setValue("file://" + urlStub, forKey: "url")
    }
}
