import Foundation

final class LoginViewModel {
    typealias Username = String
    typealias Captcha = LFLoginPageModel
    private var captcha: Captcha?
    private let dataProvider: LoginServiceProtocol
    weak var loginViewModelDelegate: LoginViewProtocol?
    let htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext")

    init(dataProvider: LoginServiceProtocol) {
        self.dataProvider = dataProvider
    }

    // func signature: , response: @escaping (Result<Username, Error>) -> Void
    func login(eMail: String, password: String, captcha: String?) {
//        loginViewModelDelegate?.displayLoadingIndicator() // MARK: main thread
        dataProvider.login(eMail: eMail, password: password, captcha: captcha) { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case let .success(username):
                strongSelf.captcha = nil
                strongSelf.loginViewModelDelegate?.authorise(username: username)
            case let .failure(error):
                strongSelf.loginViewModelDelegate?.showError(error: error)
            }

            strongSelf.loginViewModelDelegate?.removeLoadingIndicator()
        }
    }

    func checkLoginPageForCaptcha(completionForLogin: @escaping () -> Void) {
//        loginViewModelDelegate?.displayLoadingIndicator() // MARK: main thread
        if !(captcha?.captchaIsRequired ?? false) {
            checkForCaptchaAndRenderIfNecessary(htmlParserWrapper: htmlParserWrapper) {
                completionForLogin()
            }
        } else { // MARK: main thread
            let randomQueryCaptcha = URL(string: "?\(Double.random(in: 0..<1))", relativeTo: captcha!.captchaUrl)!
            renderCaptcha(url: randomQueryCaptcha) // MARK: captcha cannot be nil here. The function is evoked to prevent captcha staleness over time.
            completionForLogin()
        }
    }
    // FIXME: "'mutating' is not valid on instance methods in classes" error occurs when the capture list [captchaIsMandatory, delegate] is used
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

    func checkForCaptchaAndRenderIfNecessary(htmlParserWrapper: DVHtmlToModels, completionForLogin: @escaping () -> Void) {
        dataProvider.getLoginPage(htmlParserWrapper: htmlParserWrapper) { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case let .success(captcha):
                if captcha.captchaIsRequired {
                    strongSelf.captcha = captcha // MARK: prevent calling captcha: captcha does not require updating once it's displayed
                    strongSelf.renderCaptcha(url: captcha.captchaUrl)
                } else {
                    completionForLogin()
                }
            case let .failure(error):
                strongSelf.loginViewModelDelegate?.showError(error: error)
            }
        }
    }
}
