import Foundation

final class LoginViewModel {
    typealias Username = String
    typealias Captcha = LFLoginPageModel
    private var captcha: Captcha?
    private let dataProvider: LoginServiceProtocol
    weak var LoginViewModelDelegate: LoginViewProtocol?
    let htmlParserWrapper: DVHtmlToModels = DVHtmlToModels(contextByName: "GetLoginPageContext")

    init(dataProvider: LoginServiceProtocol) {
        self.dataProvider = dataProvider
    }

    // func signature: , response: @escaping (Result<Username, Error>) -> Void
    func login(eMail: String, password: String, captcha: String?) {
        LoginViewModelDelegate?.displayUIActivityIndicator() // MARK: main thread
        dataProvider.login(eMail: eMail, password: password, captcha: captcha) { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case let .success(username):
                strongSelf.captcha = nil
                strongSelf.LoginViewModelDelegate?.authorise(username: username)
            case let .failure(error):
                strongSelf.LoginViewModelDelegate?.showError(error: error)
            }

            strongSelf.LoginViewModelDelegate?.removeUIActivityIndicator()
        }
    }

    func checkLoginPageForCaptcha(completionForLogin: @escaping () -> Void) {
        LoginViewModelDelegate?.displayUIActivityIndicator() // MARK: main thread
        if !(captcha?.captchaIsRequired ?? false) {
            dataProvider.getLoginPage(htmlParserWrapper: htmlParserWrapper) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }

                switch result {
                case let .success(captcha):
                    if captcha.captchaIsRequired {
                        strongSelf.captcha = captcha // MARK: prevent calling captcha: captcha does not require updating once it's displayed
                        strongSelf.LoginViewModelDelegate?.updateCaptcha(url: captcha.captchaUrl)
                    } else {
                        completionForLogin()
                    }
                case let .failure(error):
                    strongSelf.LoginViewModelDelegate?.showError(error: error)
                }

                strongSelf.LoginViewModelDelegate?.removeUIActivityIndicator()
            }
        } else { // MARK: main thread
            LoginViewModelDelegate?.updateCaptcha(url: captcha!.captchaUrl) // MARK: captcha cannot be nil here. The function is evoked to prevent captcha staleness over time.
            LoginViewModelDelegate?.removeUIActivityIndicator()
            completionForLogin()
        }
    }
    // FIXME: "'mutating' is not valid on instance methods in classes" error occurs when the capture list [captchaIsMandatory, delegate] is used
}
