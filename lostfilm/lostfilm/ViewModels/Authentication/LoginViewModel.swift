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

    func login(email: String, password: String, captcha: String?) {
        if !(captchaModel?.captchaIsRequired ?? false) {
            checkForCaptcha(htmlParserWrapper: htmlParserWrapper, email: email, password: password, captcha: captcha)
        } else {
            authenticate(email: email, password: password, captcha: captcha)
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
                // TODO: stop animating captcha if failure
                loginViewModelDelegate?.showError(error: error)
            }
            loginViewModelDelegate?.removeLoadingIndicator()
        }
    }

    func checkForCaptcha(htmlParserWrapper: DVHtmlToModels, email: String, password: String, captcha: String?) {
        dataProvider.getLoginPage(htmlParserWrapper: htmlParserWrapper) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(captchaModel):
                self.captchaModel = captchaModel
                if captchaModel.captchaIsRequired {
                    self.renderCaptcha(url: captchaModel.captchaUrl)
                } else {
                    self.authenticate(email: email, password: password, captcha: captcha)
                }
            case let .failure(error):
                self.loginViewModelDelegate?.removeLoadingIndicator()
                self.loginViewModelDelegate?.showError(error: error)
            }
        }
    }

    func authenticate(email: String, password: String, captcha: String?) {
        dataProvider.login(email: email, password: password, captcha: captcha) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(username):
                self.captchaModel = nil
                self.loginViewModelDelegate?.removeLoadingIndicator()
                self.loginViewModelDelegate?.authorise(username: username)
            case let .failure(error):
//                defer {
//                    self.loginViewModelDelegate?.removeLoadingIndicator()
//                    self.loginViewModelDelegate?.showError(error: error)
//                }
                let loginServiceError = error as? LoginServiceError
                if loginServiceError == .invalidCaptcha || loginServiceError == .needCaptcha {
                    if let captchaUrl = self.captchaModel?.captchaUrl, let randomQueryCaptcha = URL(string: "?\(Double.random(in: 0 ..< 1))", relativeTo: captchaUrl) {
                        self.renderCaptcha(url: randomQueryCaptcha)
                    } else {
                        // show another error?
                        self.loginViewModelDelegate?.removeLoadingIndicator()
                    }
                } else {
                    self.loginViewModelDelegate?.removeLoadingIndicator()
                }
//                self.loginViewModelDelegate?.removeLoadingIndicator()
                self.loginViewModelDelegate?.showError(error: error)
            }
        }
    }
}
