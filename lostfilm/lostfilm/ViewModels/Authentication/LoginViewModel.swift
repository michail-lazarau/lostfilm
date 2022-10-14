import Foundation

final class LoginViewModel {
    typealias Captcha = LFLoginPageModel
    private var captchaModel: Captcha?
    private let dataProvider: LoginServiceProtocol
    private let htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext")
    weak var loginViewModelDelegate: LoginViewProtocol?

    init(dataProvider: LoginServiceProtocol) {
        self.dataProvider = dataProvider
    }

    func login(eMail: String, password: String, captcha: String?) {
        // TODO: launch loading indicator
        dataProvider.login(eMail: eMail, password: password, captcha: captcha) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(username):
                self.captchaModel = nil
                self.loginViewModelDelegate?.authorise(username: username)
            case let .failure(error):
                self.loginViewModelDelegate?.showError(error: error)
                let error = error as? LoginServiceError
                if error == .invalidCaptcha || error == .needCaptcha {
                    if let captchaUrl = self.captchaModel?.captchaUrl, let randomQueryCaptcha = URL(string: "?\(Double.random(in: 0 ..< 1))", relativeTo: captchaUrl) {
                        self.renderCaptcha(url: randomQueryCaptcha)
                    }
                }
            }
            // TODO: stop loading indicator
        }
    }

    func checkForCaptcha(completionForLogin: @escaping () -> Void) {
        // TODO: launch loading indicator
        if !(captchaModel?.captchaIsRequired ?? false) {
            checkForCaptcha(htmlParserWrapper: htmlParserWrapper) {
                completionForLogin()
            }
        } else {
            completionForLogin()
        }
    }
}

private extension LoginViewModel {
    func renderCaptcha(url: URL) {
        loginViewModelDelegate?.prepareCaptchaToDisplay()
        dataProvider.grabCaptcha(url: url) { [loginViewModelDelegate] result in
            switch result {
            case let .success(data):
                loginViewModelDelegate?.updateCaptcha(data: data)
            case let .failure(error): // Define Error: unable to load captcha
                loginViewModelDelegate?.showError(error: error)
            }
        }
    }

    func checkForCaptcha(htmlParserWrapper: DVHtmlToModels, completionForLogin: @escaping () -> Void) {
        dataProvider.getLoginPage(htmlParserWrapper: htmlParserWrapper) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(captcha):
                if captcha.captchaIsRequired {
                    self.captchaModel = captcha
                    self.renderCaptcha(url: captcha.captchaUrl)
                } else {
                    completionForLogin()
                }
            case let .failure(error):
                self.loginViewModelDelegate?.showError(error: error)
            }
        }
    }
}
