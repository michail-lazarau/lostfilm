import Foundation

final class LoginViewModel {
    typealias Username = String
    typealias Captcha = LFLoginPageModel
    private let dataProvider: LoginServiceProtocol
    let htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext")

    init(dataProvider: LoginServiceProtocol) {
        self.dataProvider = dataProvider
    }

    func login(eMail: String, password: String, captcha: String?, response: @escaping (Result<Username, Error>) -> Void) {
        dataProvider.login(eMail: eMail, password: password, captcha: captcha) { result in
            delegate.anotherMethod(result)
            switch result {
            case let .failure(error):
                delegate.handleError(error)
            case let .success(username):
                delegate.handleSuccess(username)
            }

//            response(result)
        }
    }

    func getLoginPage(response: @escaping (Result<Captcha, Error>) -> Void) {
        delegate.startLoading()
        dataProvider.getLoginPage(htmlParserWrapper: htmlParserWrapper) { result in
            delegate.anotherMethod(result)
//            response(result)
            delegate.endLoading()
        }
    }
}
