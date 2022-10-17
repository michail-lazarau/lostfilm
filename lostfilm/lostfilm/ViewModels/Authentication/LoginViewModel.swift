import Foundation

final class LoginViewModel {
    typealias Captcha = LFLoginPageModel
    private(set) var captchaModel: Captcha?
    weak var loginViewModelDelegate: LoginViewProtocol?
    let htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext")
    let dataProvider: LoginServiceProtocol

    init(dataProvider: LoginServiceProtocol) {
        self.dataProvider = dataProvider
    }

    func checkForCaptcha(eMail: String, password: String, captcha: String?) {
        // TODO: launch loading indicator
        if !(captchaModel?.captchaIsRequired ?? false) {
            checkForCaptcha(htmlParserWrapper: htmlParserWrapper, eMail: eMail, password: password, captcha: captcha)
        } else {
            login(eMail: eMail, password: password, captcha: captcha)
        }
    }
}

private extension LoginViewModel {
    func renderCaptcha(url: URL) {
        loginViewModelDelegate?.prepareCaptchaToDisplay()
        dataProvider.getCaptcha(url: url) { [loginViewModelDelegate] result in
            switch result {
            case let .success(data):
                loginViewModelDelegate?.updateCaptcha(data: data)
            case let .failure(error): // Define Error: unable to load captcha
                loginViewModelDelegate?.showError(error: error)
            }
        }
    }

    func checkForCaptcha(htmlParserWrapper: DVHtmlToModels, eMail: String, password: String, captcha: String?) {
        dataProvider.getLoginPage(htmlParserWrapper: htmlParserWrapper) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(captchaModel):
                if captchaModel.captchaIsRequired {
                    self.captchaModel = captchaModel
                    self.renderCaptcha(url: captchaModel.captchaUrl)
                } else {
                    self.login(eMail: eMail, password: password, captcha: captcha)
                }
            case let .failure(error):
                self.loginViewModelDelegate?.showError(error: error)
            }
        }
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
}
