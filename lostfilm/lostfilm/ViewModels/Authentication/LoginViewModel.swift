import Foundation

final class LoginViewModel {
    typealias Username = String
    typealias Captcha = LFLoginPageModel
    let dataProvider: LoginServiceProtocol

    init(dataProvider: LoginServiceProtocol) {
        self.dataProvider = dataProvider
    }

    func login(eMail: String, password: String, captcha: String?, completionHandler: @escaping (Result<Username, Error>) -> Void) {
        dataProvider.login(eMail: eMail, password: password, captcha: captcha) { result in
            completionHandler(result)
        }
    }

    func getLoginPageDump(completionHandler: @escaping (Result<Captcha, Error>) -> Void) {
        dataProvider.getLoginPage { result in
            completionHandler(result)
        }
    }
}
